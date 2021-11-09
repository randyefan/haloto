//
//  Extension+CALayer.swift
//  Haloto
//
//  Created by darindra.khadifa on 09/11/21.
//

import Foundation
import UIKit

extension CALayer {
    public func animate(animations: [CAAnimation],
        duration: TimeInterval? = nil,
        timingFunction: CAMediaTimingFunction? = nil,
        forKey: String? = nil,
        completion: (() -> Void)? = nil) {
        guard animations.isNotEmpty else { return }

        CATransaction.begin()

        if let completion = completion {
            CATransaction.setCompletionBlock {
                completion()
            }
        }

        if animations.count > 1 {
            let animationGroup = CAAnimationGroup()
            animationGroup.animations = animations

            if let timingFunction = timingFunction {
                animationGroup.timingFunction = timingFunction
            }
            if let duration = duration {
                animationGroup.duration = duration
            }

            add(animationGroup, forKey: forKey)
        } else if let animation = animations.first {
            if let timingFunction = timingFunction {
                animation.timingFunction = timingFunction
            }
            if let duration = duration {
                animation.duration = duration
            }

            add(animation, forKey: forKey)
        }

        CATransaction.commit()
    }
}

extension UIView {
    public static func animate(withDuration: TimeInterval,
        timingFunction: CAMediaTimingFunction,
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil) {
        CATransaction.begin()

        CATransaction.setAnimationTimingFunction(timingFunction)

        UIView.animate(withDuration: withDuration, animations: animations, completion: completion)

        CATransaction.commit()
    }
}
