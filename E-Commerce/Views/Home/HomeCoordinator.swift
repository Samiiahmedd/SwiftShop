//
//  MainCoordinator.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 06/10/2024.
//

import UIKit

@MainActor
protocol MainCoordinatorProtocol {
    func goToHomeTab()
    func gotToCartTab()
    func goToNotificationsTab()
    func goToProfileTab()
}

final class MainCoordinator {
    let window: UIWindow
    private var tabBar: MainTabBarViewController?

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBar = MainTabBarViewController()
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
        self.tabBar = tabBar
    }
}

extension MainCoordinator: MainCoordinatorProtocol {
    func goToHomeTab() {
        print("Go to home tab")
    }
    
    func gotToCartTab() {
        print("Got to cart tab")
    }
    
    func goToNotificationsTab() {
        print("Go to notifications tab")
    }
    
    func goToProfileTab() {
        print("Go to profile tab")
    }
}
