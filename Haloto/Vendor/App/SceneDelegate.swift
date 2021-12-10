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

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        if let launchedBefore = DefaultManager.shared.getBool(forKey: .isNotFirstLogin) {
            if launchedBefore {
                rootHomepageUser(scene: scene)
                return
            }
        }
        onboardingLoginpage(scene: scene)

    }

    func sceneDidDisconnect(_: UIScene) { }

    func sceneDidBecomeActive(_: UIScene) { }

    func sceneWillResignActive(_: UIScene) { }

    func sceneWillEnterForeground(_: UIScene) { }

    func sceneDidEnterBackground(_: UIScene) { }

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
        let viewController = LoginViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }

    func onboardingLoginpage(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let viewController = OnboardingLoginViewController()
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
