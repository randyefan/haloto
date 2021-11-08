//
//  Extension+UIViewController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 26/10/21.
//

import Foundation
import UIKit
import Toast_Swift
#if DEBUG
import SwiftUI

@available(iOS 13, *)
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func toPreview() -> some View {
        Preview(viewController: self)
    }
    
    func showToast(title: String) {
        var style = ToastStyle()
        style.messageColor = .white
        self.view.makeToast(title, duration: 3.0, position: .bottom, style: style)
    }
}
#endif
