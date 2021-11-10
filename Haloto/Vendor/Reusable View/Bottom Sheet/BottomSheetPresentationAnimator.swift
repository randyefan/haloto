//
//  BottomSheetPresentationAnimator.swift
//  Haloto
//
//  Created by darindra.khadifa on 09/11/21.
//

import UIKit

internal class BottomSheetPresentationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let isPresentation: Bool

    internal init(isPresentation: Bool) {
        self.isPresentation = isPresentation
        super.init()
    }

    internal func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return .T4
    }

    internal func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        guard let controller = transitionContext.viewController(forKey: key) else { return }

        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }

        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame

        dismissedFrame.origin.y = presentedFrame.origin.y + presentedFrame.height

        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame

        controller.view.frame = initialFrame

        let timingFunction = isPresentation ? CAMediaTimingFunction.easeOut : CAMediaTimingFunction.easeInOut
        let duration = transitionDuration(using: transitionContext)

        UIView.animate(withDuration: duration, timingFunction: timingFunction, animations: {
            controller.view.frame = finalFrame
        }, completion: { _ in
                transitionContext.completeTransition(true)
            })
    }
}
