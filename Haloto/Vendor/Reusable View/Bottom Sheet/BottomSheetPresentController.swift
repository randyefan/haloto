//
//  BottomSheetPresentController.swift
//  Haloto
//
//  Created by darindra.khadifa on 09/11/21.
//

import AsyncDisplayKit
import Foundation
import RxKeyboard
import RxOptional
import UIKit

internal class BottomSheetPresentController: UIPresentationController {
    // Use computed property to support split view and screen rotate
    private var windowSize: CGSize {
        let window = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        let windowWidth = window?.frame.width ?? UIScreen.adaptiveWidth
        let windowHeight = window?.frame.height ?? UIScreen.main.bounds.height

        return CGSize(width: windowWidth, height: windowHeight)
    }

    private var maxFrameSize: CGSize {
        CGSize(width: windowSize.width, height: windowSize.height * maxHeightMultiplier)
    }

    private lazy var panGesture: UIPanGestureRecognizer = {
        UIPanGestureRecognizer(target: self, action: #selector(dismiss))
    }()

    private lazy var tapGesture: UITapGestureRecognizer = {
        UITapGestureRecognizer(target: self, action: #selector(dismiss))
    }()

    private var keyboardVisibleHeight: CGFloat = 0
    private let maxHeightMultiplier: CGFloat = 0.95
    private let dimmingView = UIView()
    private var hasBeenDismissed = false

    private let isClosable: Bool
    private let heightSizingMode: BottomSheetTransitionDelegate.SheetType
    private let onTapOverlayToDismiss: ((BottomsheetDismissType) -> Void)?

    internal init(presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?,
        isClosable: Bool,
        heightSizingMode: BottomSheetTransitionDelegate.SheetType,
        onTapOverlayToDismiss: ((BottomsheetDismissType) -> Void)? = nil) {
        self.isClosable = isClosable
        self.heightSizingMode = heightSizingMode
        self.onTapOverlayToDismiss = onTapOverlayToDismiss
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] keyboardVisibleHeight in
            self?.keyboardVisibleHeight = keyboardVisibleHeight

            switch heightSizingMode {
            case .resizableHeight, .fitContentHeight, .fullscreen:
                UIView.animate(withDuration: 0.5, animations: { [weak self] in
                    guard let self = self else { return }
                    self.presentedView?.frame = self.frameOfPresentedViewInContainerView
                })
            case .knob:
                break
            }
        })
            .disposed(by: rx.disposeBag)

        if isClosable {
            dimmingView.addGestureRecognizer(panGesture)
            dimmingView.addGestureRecognizer(tapGesture)
        }
    }

    private var preferredContentHeight: CGFloat {
        if let navigationController = presentedViewController as? UINavigationController,
            let viewController = navigationController.viewControllers.first {
            let navigationBarHeight = navigationController.navigationBar.isHidden ? 0 : navigationController.navigationBar.bounds.height
            let contentHeight: CGFloat

            if let asViewController = viewController as? ASDKViewController {
                let rootNode: ASDisplayNode = asViewController.node
                rootNode.layoutIfNeeded()

                if let tableNode = rootNode as? ASTableNode {
                    tableNode.scrollView.layoutIfNeeded()
                    contentHeight = tableNode.scrollView.contentSize.height + tableNode.scrollView.safeAreaInsets.top + tableNode.scrollView.safeAreaInsets.bottom
                } else if let collectionNode = rootNode as? ASCollectionNode {
                    collectionNode.scrollView.layoutIfNeeded()
                    contentHeight = collectionNode.scrollView.contentSize.height
                } else if let scrollNode = rootNode as? ASScrollNode, let subnodes = scrollNode.subnodes, subnodes.isNotEmpty {
                    // ASScrollNode will automatically make the content height to be full,
                    // so we need to determine the height from its subnode instead
                    var subnodeHeight: CGFloat = 0
                    for subnode in subnodes {
                        subnodeHeight = max(subnode.frame.maxY, subnodeHeight)
                    }
                    contentHeight = subnodeHeight
                } else {
                    let sizeRange = ASSizeRangeMake(CGSize(width: maxFrameSize.width, height: 0), CGSize(width: maxFrameSize.width, height: maxFrameSize.height - navigationBarHeight))
                    let layout = rootNode.layoutThatFits(sizeRange)
                    contentHeight = layout.size.height
                }
            } else {
                contentHeight = viewController.view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            }

            return min(navigationBarHeight + contentHeight, maxFrameSize.height)
        }

        return maxFrameSize.height
    }

    override internal var preferredContentSize: CGSize {
        switch heightSizingMode {
        case .fitContentHeight:
            return CGSize(width: maxFrameSize.width, height: preferredContentHeight)
        case .resizableHeight, .fullscreen, .knob:
            return maxFrameSize
        }
    }

    override internal var frameOfPresentedViewInContainerView: CGRect {
        let contentSize = preferredContentSize
        let maxYOrigin = windowSize.height - maxFrameSize.height

        var calculatedYOrigin: CGFloat = 0
        switch heightSizingMode {
        case .resizableHeight:
            calculatedYOrigin = windowSize.height - preferredContentHeight - keyboardVisibleHeight
        case .fitContentHeight, .fullscreen:
            calculatedYOrigin = windowSize.height - contentSize.height - keyboardVisibleHeight
        case .knob:
            if case let .knob(height, _) = heightSizingMode {
                if height == .fitContentHeight {
                    calculatedYOrigin = max(windowSize.height / 2, 0)
                }
            }
        }

        let presentedOrigin = CGPoint(x: 0, y: max(calculatedYOrigin, maxYOrigin))
        let presentedFrame = CGRect(origin: presentedOrigin, size: contentSize)

        return presentedFrame
    }

    override internal func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }

        setViewTopCornerRadius()

        containerView.insertSubview(dimmingView, at: 1)
        dimmingView.frame = containerView.frame
        dimmingView.backgroundColor = .backgroundOverlay
        dimmingView.alpha = 0.0
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            self?.dimmingView.alpha = 0.68
        }, completion: nil)
    }

    override internal func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            self?.dimmingView.alpha = 0.0
        }, completion: nil)
    }

    override internal func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    // This func is interface for the our bottomsheet use,
    // so we no need directly use containerViewWillLayoutSubviews() method
    internal func relayout() {
        containerViewWillLayoutSubviews()
    }

    override internal func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setViewTopCornerRadius()
        coordinator.animate(alongsideTransition: { [weak self] _ in
            guard let self = self else { return }
            self.dimmingView.frame.size = size
        }, completion: nil)
    }

    // Add Top Left and Top Right corner in presented view.
    private func setViewTopCornerRadius() {
        presentedView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        presentedView?.layer.cornerRadius = 10
    }

    @objc private func dismiss() {
        /// this is to prevent double dismiss happens when `UIPanGesture` is recognized
        /// that results in `presentingViewController` being dismissed twice
        if hasBeenDismissed { return }
        hasBeenDismissed = true

        // need to move out this,
        // we need to set dismissType before start dismiss the bottomsheet
        // because it caused dismissType not being set
        onTapOverlayToDismiss?(.onTouchOverlay)

        // for knob, the bottomsheet will dismiss first, then do the function given
        presentingViewController.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }

            if case let .knob(_, customBlock) = self.heightSizingMode,
                let completion = customBlock {
                completion()
            }
        }
    }
}

