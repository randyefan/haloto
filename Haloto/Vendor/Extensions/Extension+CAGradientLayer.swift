//
//  Extension+CAGradientLayer.swift
//  Haloto
//
//  Created by darindra.khadifa on 05/11/21.
//

import Foundation
import UIKit

extension CAGradientLayer {
    func setGradientLayerForBackgroundHome(view: UIView, color1: UIColor, color2: UIColor) {
        self.frame = CGRect(x: view.frame.minX, y: view.frame.minY, width: view.frame.width, height: view.frame.height)
        self.colors = [color1.cgColor, color2.cgColor]
        self.locations = [0.0, 0.3]
        self.startPoint = CGPoint(x: 0.0, y: 1.0)
        self.endPoint = CGPoint(x: 1.0, y: 1.0)
    }
}
