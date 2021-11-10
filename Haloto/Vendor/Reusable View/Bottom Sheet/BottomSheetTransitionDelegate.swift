//
//  BottomSheetTransitionDelegate.swift
//  Haloto
//
//  Created by darindra.khadifa on 09/11/21.
//

import Foundation
import UIKit

internal class BottomSheetTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    internal enum SheetType {
        case resizableHeight
        case fitContentHeight
        case fullscreen
        case knob(heightState: BottomSheetViewController.HeightSizingMode, completion: (() -> Void)?)
    }

    private let isClosable: Bool
    private let heightSizingMode: SheetType
    private let onDismissCallback: ((BottomsheetDismissType) -> Void)?

    public init(isClosable: Bool,
        heightSizingMode: SheetType,
        onDismissCallback: ((BottomsheetDismissType) -> Void)? = nil) {
        self.isClosable = isClosable
        self.heightSizingMode = heightSizingMode
        self.onDismissCallback = onDismissCallback
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source _: UIViewController) -> UIPresentationController? {
        return BottomSheetPresentController(
            presentedViewController: presented,
            presenting: presenting,
            isClosable: isClosable,
            heightSizingMode: heightSizingMode,
            onTapOverlayToDismiss: onDismissCallback
        )
    }

    internal func animationController(forPresented _: UIViewController, presenting _: UIViewController, source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomSheetPresentationAnimator(isPresentation: true)
    }

    internal func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomSheetPresentationAnimator(isPresentation: false)
    }
}
