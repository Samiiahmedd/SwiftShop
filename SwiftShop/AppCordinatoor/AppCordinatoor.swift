//
//  AppCordinatoor.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 23/10/2024.
//

import Foundation
import UIKit

final class AppCoordinator {
    let window: UIWindow
    var authCoordinator: AuthCoordinator?
    var mainCoordinator: MainCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if isAuthenticated() {
            goToHomeFlow()
        } else {
            goToAuthFlow()
        }
    }
    
    func isAuthenticated() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    
    func goToAuthFlow() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.start()
        self.authCoordinator = authCoordinator
    }
    
    func goToHomeFlow() {
        let mainCoordinator = MainCoordinator(window: window)
        mainCoordinator.start()
        self.mainCoordinator = mainCoordinator
    }
}
