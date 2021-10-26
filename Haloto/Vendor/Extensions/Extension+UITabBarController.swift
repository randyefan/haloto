//
//  Extension+UITabBarController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 26/10/21.
//

import Foundation
import UIKit

extension UITabBarController {
    func showToast(title: String) {
        var style = ToastStyle()
        style.messageColor = .white
        self.view.makeToast(title, duration: 3.0, position: .bottom, style: style)
    }
}
