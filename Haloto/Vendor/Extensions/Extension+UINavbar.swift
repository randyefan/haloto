//
//  Extension+UINavbar.swift
//  Haloto
//
//  Created by darindra.khadifa on 09/11/21.
//

import UIKit

extension UINavigationBar {
    /// You should use this method to modify the navigation bar background color.
    /// This method supports the iOS 15 appearance API to adjust the background color appearance.
    public func setBackgroundColor(_ backgroundColor: UIColor) {
        isTranslucent = false

        if #available(iOS 15.0, *) {
            let appearance = standardAppearance.copy()
            appearance.backgroundColor = backgroundColor
            standardAppearance = appearance
            scrollEdgeAppearance = appearance
        } else {
            barTintColor = backgroundColor
        }
    }

    /// You should use this method to show/hide the default navigation bar line shadow.
    /// This method supports the iOS 15 appearance API to adjust the shadow appearance.
    public func setLineShadowVisible(_ lineShadowVisible: Bool) {
        let color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
        let shadowColor = lineShadowVisible ? color : nil
        let shadowImage = lineShadowVisible ? UIImage(color: color, size: CGSize(width: 1, height: 0.3)) : UIImage()

        if #available(iOS 15.0, *) {
            let appearance = standardAppearance.copy()
            appearance.shadowColor = shadowColor
            appearance.shadowImage = shadowImage
            standardAppearance = appearance
            scrollEdgeAppearance = appearance
        } else {
            setBackgroundImage(lineShadowVisible ? UIImage(color: .clear) : UIImage(), for: .default)
            self.shadowImage = shadowImage
        }
    }
}
