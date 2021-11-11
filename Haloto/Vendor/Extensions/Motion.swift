//
//  Motion.swift
//  Haloto
//
//  Created by darindra.khadifa on 09/11/21.
//

import Foundation
import UIKit

extension TimeInterval {
    /// Duration 0.120s
    public static let T1 = TimeInterval(0.120)
    /// Duration 0.200s
    public static let T2 = TimeInterval(0.200)
    /// Duration 0.300s
    public static let T3 = TimeInterval(0.300)
    /// Duration 0.400s
    public static let T4 = TimeInterval(0.400)
    /// Duration 0.600s
    public static let T5 = TimeInterval(0.600)
}

extension CAMediaTimingFunction {
    public static let defaultTiming = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
    public static let defaultLinear = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    public static let defaultEaseIn = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
    public static let defaultEaseOut = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    public static let defaultEaseInEaseOut = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

    public static let linear = CAMediaTimingFunction(controlPoints: 0, 0, 1, 1)
    public static let easeOut = CAMediaTimingFunction(controlPoints: 0.2, 0.64, 0.21, 1)
    public static let easeInOut = CAMediaTimingFunction(controlPoints: 0.63, 0.01, 0.29, 1)
    public static let overshoot = CAMediaTimingFunction(controlPoints: 0.63, 0.01, 0.19, 1.55)
}

