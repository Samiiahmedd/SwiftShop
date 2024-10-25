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
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        AppCoordinator.shared.makeWindo(from: windowScene)
        AppCoordinator.shared.start()
    }
}
