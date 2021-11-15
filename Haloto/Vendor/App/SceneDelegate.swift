//
//  SceneDelegate.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 26/10/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private(set) static var shared: SceneDelegate?

    var window: UIWindow?

    // MARK: - Window Scene Delegate

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        if let token = DefaultManager.shared.getString(forKey: .AccessTokenKey) {
            if !token.isEmpty {
                rootHomepageUser(scene: scene)
                return
            }
        }
        loginPage(scene: scene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

    // MARK: - Functionality
    func createExampleModule(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let viewController = LoginViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
    }

    func loginPage(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = AddNewVehicleViewController(vehicle: nil, type: .add)
        let navigation = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }

    func rootHomepageUser(scene: UIScene) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        let tabBar = TabBarBaseController(productLogin: .User)
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }

    func rootHomepageBengkel(scene: UIScene) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        let tabBar = TabBarBaseController(productLogin: .Bengkel)
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
    }
}

