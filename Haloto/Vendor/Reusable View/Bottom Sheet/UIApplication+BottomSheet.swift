//
//  UIApplication+BottomSheet.swift
//  Haloto
//
//  Created by darindra.khadifa on 09/11/21.
//
import UIKit

extension UIApplication {
    internal class func topViewController() -> UIViewController? {
        var top = UIApplication.shared.keyWindow?.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as?
                UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}

