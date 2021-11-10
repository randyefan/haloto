//
//  BottomSheetViewController.swift
//  Haloto
//
//  Created by darindra.khadifa on 09/11/21.
//

import AsyncDisplayKit
import Foundation
import RxCocoa
import RxSwift
import UIKit

public class BottomSheetViewController: UINavigationController {
    /// Defines how your view controller will be presented
    public enum HeightSizingMode {
        /// The size of the presentation will follow the height of the view controller and could be updated to follow the latest height.
        /// Basically the view controller will be presented in full screen, but the position will be set so the displayed part follows the view controller height.
        /// How the height is determined is the same as the fit content height sizing mode.
        case resizableHeight

        /// The size of the presentation content will follow the implicit height of the view controller
        /// How the height is determined:
        /// - If the view controller is an instance of ASDKViewController, the height will be determined from the view controller's node height.
        ///   If the root node is ASTableNode or ASCollectionNode, the content size will be used, if the root node is ASScrollNode, its subnodes height will be used,
        ///   other than that, the root node height will be used, calculated using `ASDisplayNode.layoutThatFits(_:)` method.
        /// - Otherwise, the height will be determined from view controller's view by using `UIView.systemLayoutSizeFitting(_:)` method
        ///
        /// ![](resource://BottomSheet/bottom-sheet-fit.png)
        case fitContentHeight

        /// The view controller will be presented in almost full screen, leaving a small gap
        /// ![](resource://BottomSheet/bottom-sheet-full.png)
        case fullscreen

        internal func getSheetType() -> BottomSheetTransitionDelegate.SheetType {
            switch self {
            case .resizableHeight:
                return .resizableHeight
            case .fitContentHeight:
                return .fitContentHeight
            case .fullscreen:
                return .fullscreen
            }
        }
    }

    internal private(set) var dismissType: BottomsheetDismissType = .default

    private let maxHeightMultiplier: CGFloat = 0.95
    private let cancelBarButtonItem = UIBarButtonItem(image: UIImage(named: "x_icon"), style: .plain, target: self, action: nil)

    private var bottomSheet: BottomSheetTransitionDelegate?
    private let presentedVC: UIViewController
    private let isClosable: Bool
    private let heightSizingMode: HeightSizingMode
    private let onDismiss: ((BottomsheetDismissType) -> Void)?

    /// - Parameters:
    ///   - presentedVC: view controller to be presented
    ///   - isClosable: if true, a navigation bar will be shown along with the close button on the top left
    ///   - heightSizingMode: decide how the bottom sheet should calculate its height
    ///   - onDismiss: custom action to execute when Bottom Sheet is dismissed, could be by tapping the close button or the overlay
    ///   - dismissBarButtonAccessibilityIdentifier: accessibility identifier for the close button
    public init(wrapping presentedVC: UIViewController,
        isClosable: Bool = true,
        heightSizingMode: HeightSizingMode = .fitContentHeight,
        onDismiss: ((BottomsheetDismissType) -> Void)? = nil,
        dismissBarButtonAccessibilityIdentifier: String? = nil) {
        self.presentedVC = presentedVC
        self.isClosable = isClosable
        self.heightSizingMode = heightSizingMode
        self.onDismiss = onDismiss

        super.init(nibName: nil, bundle: nil)

        bottomSheet = BottomSheetTransitionDelegate(
            isClosable: isClosable,
            heightSizingMode: heightSizingMode.getSheetType(),
            onDismissCallback: { [weak self] dismissType in
                self?.dismissType = dismissType
            }
        )

        modalPresentationStyle = .custom
        transitioningDelegate = bottomSheet

        setupNavigationBar()
        setupTitleObserver()
        setupBottomSheet()

        cancelBarButtonItem.accessibilityIdentifier = dismissBarButtonAccessibilityIdentifier ?? "bottomSheetCloseButton"
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // why we add in here to force header color?
        // by default our navigation background color is being set by using swizzle
        // in UIKitExtension when didLoad
        // so we need to override again in viewWillAppear
        let headerBackgroundColor: UIColor = .white
        // we set backgroundColor for header bottomsheet in darkmode
        navigationBar.setBackgroundColor(headerBackgroundColor)
        navigationBar.setLineShadowVisible(false)
    }

    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        onDismiss?(dismissType)
    }

    override public func pushViewController(_ viewController: UIViewController, animated _: Bool) {
        dismiss(animated: true) {
            UIApplication.topViewController()?.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    override public func accessibilityPerformEscape() -> Bool {
        dismiss(animated: true, completion: nil)
        onDismiss?(.default)
        return true
    }

    /// Only work for the `resizableHeight` height sizing mode. To be called after you make some adjustments in your view controller content
    /// and wishing to update and readjust the Bottom Sheet height to follow the latest content height.
    public func relayout(animated: Bool = true) {
        if !Thread.isMainThread {
            assertionFailure("This \(#function) function must be called from the main thread.")
            return
        }

        // instead of we use reference variable,
        // we get our presentationController from here and typecast it
        guard presentationController is BottomSheetPresentController,
            let currentPresentController = presentationController as? BottomSheetPresentController
            else {
            assertionFailure("presentationController is not BottomSheetPresentController, please report to UXE Team about this info")
            return
        }

        if animated {
            UIView.animate(withDuration: .T3) { [weak currentPresentController] in
                currentPresentController?.relayout()
            }
        } else {
            currentPresentController.relayout()
        }
    }

    private func setupTitleObserver() {
        // Observe title change in the presented view controller to set it as left navigation item so the expected style could be applied
        presentedVC.rx.observeWeakly(String.self, "title")
            .distinctUntilChanged()
            .asDriverOnErrorJustComplete()
            .drive(onNext: { [weak self] title in
            self?.setTitle(title ?? "")
        }).disposed(by: rx.disposeBag)
    }

    // To set the title as left navigation item and remove the presented view controller title to prevent multiple titles
    private func setTitle(_ title: String) {
        // Title is only used for closable Bottom Sheet
        guard isClosable else { return }

        // Update the title by accessing the left bar button item as UILabel, append a new one if not found
        if let leftItemCustomView = presentedVC.navigationItem.leftBarButtonItems?.first(where: { $0.customView != nil }),
            let titleLabel = leftItemCustomView.customView as? UILabel {
            // Updating the text directly causes the text to be truncated and calling setNeedsLayout doesn't give any effect, need to set the frame to kinda force the container to update its size
            titleLabel.attributedText = .font(title, size: 18, fontWeight: .regular)
            titleLabel.frame = .zero
        } else {
            let titleLabel = UILabel()
            titleLabel.attributedText = .font(title, size: 18, fontWeight: .regular)
            titleLabel.accessibilityIdentifier = "bottomSheetTitle"
            titleLabel.sizeToFit()
            titleLabel.lineBreakMode = .byTruncatingTail

            let titleBarButtonItem = UIBarButtonItem(customView: titleLabel)
            presentedVC.navigationItem.leftBarButtonItems?.append(titleBarButtonItem)
        }

        // Use empty view to emptied the real title because setting title to nil would trigger the title observer
        presentedVC.navigationItem.titleView = UIView()
    }

    private func setupNavigationBar() {
        let navigationBarIsHidden: Bool
        if !isClosable {
            navigationBarIsHidden = true
        } else {
            navigationBar.setBackgroundColor(.white)

            cancelBarButtonItem.tintColor = UIColor.greyApp

            cancelBarButtonItem.rx.tap.asDriver()
                .drive(onNext: { [weak self] _ in
                guard let self = self else { return }

                self.dismissType = .onCloseButton
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            })
                .disposed(by: rx.disposeBag)

            presentedVC.navigationItem.leftBarButtonItems = [cancelBarButtonItem]
            setTitle(title ?? "")

            navigationBarIsHidden = false
        }

        navigationBar.isHidden = navigationBarIsHidden
    }

    private func setupBottomSheet() {
        viewControllers = [presentedVC]
    }
}

public enum BottomsheetDismissType: Equatable {
    case `default`
    case onCloseButton
    case onTouchOverlay
}
