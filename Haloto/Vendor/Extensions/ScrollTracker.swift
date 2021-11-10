//
//  ScrollTracker.swift
//  Haloto
//
//  Created by darindra.khadifa on 09/11/21.
//

import AsyncDisplayKit
import RxCocoa
import RxSwift
import UIKit

public enum ScrollingTreshold {
    case percentage(CGFloat)
    case points(CGFloat)

    internal func passesTreshold(currentLength: CGFloat, parentLength: CGFloat) -> Bool {
        switch self {
        case let .percentage(percentage):
            return currentLength / parentLength >= percentage
        case let .points(points):
            return currentLength >= points
        }
    }
}

public protocol ScrollTrackable: AnyObject {
    var visibilityTreshold: ScrollingTreshold { get }

    func didEnterViewport()

    /// *Important* Not guaranteed to be called
    func didExitViewport()

    func visibleBy(percentage: CGFloat)
}

extension ScrollTrackable {
    public func didEnterViewport() { }

    public func didExitViewport() { }

    public func visibleBy(percentage _: CGFloat) { }

    public var visibilityTreshold: ScrollingTreshold {
        return .percentage(0.3)
    }
}

// ASDisplayNode is the common parent of ASScrollNode, ASCollectionNode and ASTableNode
// we have to find a way to provide the scroll view since ASDisplayNode doesn't have a scroll view
public protocol ScrollViewProvider {
    var scrollView: UIScrollView { get }
}

extension ASScrollNode: ScrollViewProvider {
    public var scrollView: UIScrollView {
        return view
    }
}

extension ASCollectionNode: ScrollViewProvider {
    public var scrollView: UIScrollView {
        return view
    }
}

extension ASTableNode: ScrollViewProvider {
    public var scrollView: UIScrollView {
        return view
    }
}

public class ScrollTracker: NSObject {
    public enum ScrollDirection {
        case horizontal
        case vertical

        internal var observedProperty: KeyPath<CGRect, CGFloat> {
            switch self {
            case .horizontal: return \.size.width
            case .vertical: return \.size.height
            }
        }
    }

    private let scrollNode: ASDisplayNode & ScrollViewProvider
    private let scrollDirection: ScrollDirection

    // Tracks which nodes have entered viewport. NSHashTable is used instead of Array
    // because we need to be able to lookup the nodes in fastest time possible
    private let table: NSHashTable<ASDisplayNode>
    private var observationDisposeBag: DisposeBag = DisposeBag()

    public init(scrollNode: ASDisplayNode & ScrollViewProvider, scrollDirection: ScrollDirection = .vertical) {
        self.scrollNode = scrollNode
        self.scrollDirection = scrollDirection
        table = NSHashTable(options: .weakMemory)
        super.init()
    }

    // Find out which nodes are going out of bounds
    private func invalidateOutOfBoundNodes(in scrollView: UIScrollView) {
        let allNodes = table.allObjects

        if scrollView.window != nil {
            // only do checking when scroll view is attached to a window

            allNodes.forEach { node in
                if !nodeIsInsideScrollViewAndAttachedToWindow(node: node, scrollView: scrollView) {
                    let trackable = node as? ScrollTrackable
                    trackable?.didExitViewport()
                    table.remove(node)
                }
            }
        } else {
            // otherwise it is safe to assume that all nodes will not be inside the viewport

            allNodes.forEach { node in
                let trackable = node as? ScrollTrackable
                trackable?.didExitViewport()
            }

            table.removeAllObjects()
        }
    }

    private func trackViewport(node: ASDisplayNode, scrollView: UIScrollView) {
        if !nodeIsInsideScrollViewAndAttachedToWindow(node: node, scrollView: scrollView) {
            return
        }

        let isAlreadyInViewport = table.contains(node)

        if let trackable = node as? ScrollTrackable, !isAlreadyInViewport {
            trackable.didEnterViewport()
            table.add(node)
        } else {
            let children: [ASDisplayNode]

            // you can't use subnodes property from ASCollectionNode and ASTableNode
            // they both return empty arrays even though the cells are already populated
            if let collectionNode = node as? ASCollectionNode {
                children = collectionNode.visibleNodes
            } else if let tableNode = node as? ASTableNode {
                children = tableNode.visibleNodes
            } else {
                children = node.subnodes ?? []
            }

            children.forEach { node in
                trackViewport(node: node, scrollView: scrollView)
            }
        }
    }

    private func nodeIsInsideScrollViewAndAttachedToWindow(node: ASDisplayNode, scrollView: UIScrollView) -> Bool {
        guard let window = scrollView.window else {
            return false
        }

        let nodeFrameOnWindow: CGRect
        let nodeFrameOnScrollView: CGRect

        if !node.isLayerBacked {
            let view = node.view
            nodeFrameOnWindow = view.convert(view.bounds, to: window)
            nodeFrameOnScrollView = view.convert(view.bounds, to: scrollView)
        } else {
            let layer = node.layer
            nodeFrameOnWindow = layer.convert(layer.bounds, to: window.layer)
            nodeFrameOnScrollView = layer.convert(layer.bounds, to: scrollView.layer)
        }

        let intersection = nodeFrameOnScrollView.intersection(scrollView.bounds)

        let currentLength = intersection[keyPath: scrollDirection.observedProperty]
        let parentLength = node.bounds[keyPath: scrollDirection.observedProperty]

        let treshold: ScrollingTreshold
        if let trackable = node as? ScrollTrackable {
            trackable.visibleBy(percentage: min(1, max(0, currentLength / parentLength)))

            treshold = trackable.visibilityTreshold
        } else {
            treshold = .points(0)
        }

        return nodeFrameOnWindow.intersects(window.bounds) && treshold.passesTreshold(currentLength: currentLength, parentLength: parentLength)
    }

    public func startTracking() {
        observationDisposeBag = DisposeBag()

        // We use methodInvoked because it will be called after super was called (contentOffset is already set) so we can prevent collision between RxCocoa interception mechanism and KVO
        scrollNode.scrollView.rx.methodInvoked(#selector(setter: UIScrollView.contentOffset))
            .throttle(.milliseconds(50), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self, scrollNode] _ in
            self?.invalidateOutOfBoundNodes(in: scrollNode.scrollView)

            // do not track if the scroll view is not attached to the window
            guard scrollNode.scrollView.window != nil else {
                return
            }

            self?.trackViewport(node: scrollNode, scrollView: scrollNode.scrollView)
        })
            .disposed(by: observationDisposeBag)
    }
}

