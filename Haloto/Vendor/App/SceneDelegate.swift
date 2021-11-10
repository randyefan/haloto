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
        guard let windowScene = (scene as? UIWindowScene) else {
          return
        }
        let window = UIWindow(windowScene: windowScene)
        AppController.shared.show(in: window)
    }
}

