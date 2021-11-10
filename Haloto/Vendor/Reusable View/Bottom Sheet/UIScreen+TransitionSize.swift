//
//  UIScreen+TransitionSize.swift
//  Haloto
//
//  Created by darindra.khadifa on 09/11/21.
//

import Foundation
import UIKit

public extension UIScreen {
    /// Adaptive width based on device and orientation
    ///     on iPad landscape -> we're going to only use `3/4 of the screen's width`
    ///     for the rests -> we're going to use the `whole screen's width`
    static var adaptiveWidth: CGFloat {
        return ScreenHelper.shared.currentWidth
    }

    /// Adaptive origin of X axis based on device and orientation
    ///     on iPad landscape -> the X axis will be `1/8 of the screen's width`
    ///     for the restse -> the X axis will be starting from `0`
    static var adaptiveOriginX: CGFloat {
        return ScreenHelper.shared.currentAdaptiveOriginX
    }
}

/// This is a helper class to store the current screen's width and X origin.
///     It is created to support the usage of `UIScreen.width` on our apps with the right calculation
///     so that it will work appropriately when we start implementing sidebar and tabbar navigation.
///
///     In addition, it is also thread safe since all properties required to get the value are accessed
///     in the main thread (inside `MainViewController.swift`).
public final class ScreenHelper {
    /// Storing current window's width based on layout type
    ///     on iPad landscape -> we're going to only use `3/4 of the screen's width`
    ///     for the rests -> we're going to use the `whole screen's width`
    public private(set) var currentWidth: CGFloat = UIScreen.main.bounds.width

    /// Storing current window's adaptive origin of X axis
    ///     on iPad landscape -> the X axis will be `1/8 of the screen's width`
    ///     for the restse -> the X axis will be starting from `0`
    public private(set) var currentAdaptiveOriginX: CGFloat = 0

    public static let shared = ScreenHelper()

    /// A function to update the sizing properties stored in this class based on the orientation and UIScreen value
    public func updateSizingProperties(isOrientationLandscape: Bool, screenSize: CGSize) {
        guard Thread.isMainThread else {
            assertionFailure("updateSizingProperties method should be called in Main Thread")
            return
        }

        let isIpadLandscape = (UIDevice.current.userInterfaceIdiom == .pad && isOrientationLandscape)

        if isIpadLandscape {
            currentWidth = screenSize.width * 0.75
            currentAdaptiveOriginX = screenSize.width / 8
        } else {
            currentWidth = screenSize.width
            currentAdaptiveOriginX = 0
        }
    }
}

