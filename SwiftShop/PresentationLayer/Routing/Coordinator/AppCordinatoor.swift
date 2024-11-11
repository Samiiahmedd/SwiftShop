//
//  AppCordinatoor.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 23/10/2024.
//

import Foundation
import UIKit

final class AppCoordinator {
    
    var windo: UIWindow?
    var isLogin = false
    
    var router: Router
    
    static let shared = AppCoordinator()
    
    
    private init() {
        router = AppRouter(navigationController: .init())
        router.navigationController.navigationBar.isHidden = true
        let userData = UserDefaults.standard.data(forKey: "User")
        isLogin = userData == nil ? false : true
    }
}

extension AppCoordinator: Coordinator {
    func start() {
        if isLogin {
            showTabBar()
        } else {
            showAuth()
        }
    }
    
    func makeWindo(from windoScene: UIWindowScene) {
        let windo = UIWindow(windowScene: windoScene)
        windo.rootViewController = self.router.navigationController
        windo.makeKeyAndVisible()
        self.windo = windo
    }
    
    func showOnBoarding() {
        
    }
    
    func showAuth() {
        let authCoordinator = AuthCoordinator(router: self.router)
        router.reset()
        authCoordinator.start()
    }
    
    func showTabBar() {
        let coordinator = TabBarCoordinator(router: self.router)
        router.reset()
        coordinator.start()
    }
    

}
