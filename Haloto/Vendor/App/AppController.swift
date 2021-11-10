//
//  AppController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 10/11/21.
//

import UIKit
import Firebase

final class AppController {
    static let shared = AppController()
    private var window: UIWindow!
    
    private var rootViewController: UIViewController? {
        didSet {
            window.rootViewController = rootViewController
        }
    }
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleAppState),
            name: .AuthStateDidChange,
            object: nil)
    }
    
    // MARK: - Helpers
    func configureFirebase() {
        FirebaseApp.configure()
    }
    
    func show(in window: UIWindow?) {
        guard let window = window else {
            fatalError("Cannot layout app with a nil window.")
        }
        
        self.window = window
        window.tintColor = .primary
        window.backgroundColor = .white
        
        handleAppState()
        
        window.makeKeyAndVisible()
    }
    
    // MARK: - Notifications
    @objc private func handleAppState() {
//        if let _ = Auth.auth().currentUser {
//            if let type = AppSettings.displayName, type == "Bengkel" {
//                print("Bengkel")
//            } else {
//                let tabBar = TabBarBaseController(productLogin: .User)
//                rootViewController = tabBar
//            }
//        } else {
        if let name = AppSettings.displayName, name == "Bengkel" {
            if let auth = Auth.auth().currentUser {
                bengkelChannel(user: auth)
            } else {
                let viewController = LoginViewController()
                let navigation = UINavigationController(rootViewController: viewController)
                rootViewController = navigation
            }
        } else {
            if let _ = AppSettings.displayName {
                userTabBar()
            } else {
                let viewController = LoginViewController()
                let navigation = UINavigationController(rootViewController: viewController)
                rootViewController = navigation
            }
        }
//        }
    }
    
    func userTabBar() {
        let tabBar = TabBarBaseController(productLogin: .User)
        rootViewController = tabBar
    }
    
    func bengkelChannel(user: User) {
        let channelsViewController = ChannelsViewController(currentUser: user)
        let nav = UINavigationController(rootViewController: channelsViewController)
        rootViewController = nav
    }
}

