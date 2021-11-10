//
//  Extension+UITabBarController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 09/11/21.
//

import UIKit

extension UITabBarController {
    func hideTabBar() {
        self.view.viewWithTag(700)?.isHidden = true
        self.view.viewWithTag(800)?.isHidden = true
        self.view.viewWithTag(900)?.isHidden = true
        self.view.viewWithTag(1000)?.isHidden = true
        self.view.viewWithTag(1100)?.isHidden = true
    }
    
    func showTabBar() {
        self.view.viewWithTag(700)?.isHidden = false
        self.view.viewWithTag(800)?.isHidden = false
        self.view.viewWithTag(900)?.isHidden = false
        self.view.viewWithTag(1000)?.isHidden = false
        self.view.viewWithTag(1100)?.isHidden = false
    }
}
