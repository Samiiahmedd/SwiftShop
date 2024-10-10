//
//  SceneDelegate.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 17/07/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = GFNavigationController()
        window?.makeKeyAndVisible()
    }
}

// MARK: - HANDEL APP ROOT

private extension SceneDelegate {
    func appRoot(for window: UIWindow) {
        window.rootViewController = GFNavigationController()
        window.makeKeyAndVisible()
    }
}

