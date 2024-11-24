//
//  TabBarCoordinator.swift
//  SwiftShop
//
//  Created by Abdalazem Saleh on 26/10/2024.
//

import UIKit

@MainActor


protocol TabBarCoordinatorProtocol: Coordinator {
    func goToHomeTab()
    func gotToOrdersTab()
    func goToNotificationsTab()
    func goToProfileTab()
}

final class TabBarCoordinator {
    var router: any Router
    private var tabBar: MainTabBarViewController?

    init(router: Router) {
        self.router = router
    }
    
    func start() {
        let tabBarControllers: [UIViewController] = [
            homeNC(),
            ordersNC(),
            notificationsNC(),
            profileNC()
        ]
        
        let tabBar = MainTabBarViewController(controllers: tabBarControllers)
        self.tabBar = tabBar
        router.push(tabBar)
    }
    
    private func homeNC() -> UINavigationController {
        let navigationController = UINavigationController()
        let router = AppRouter(navigationController: navigationController)
        let coordinator = HomeCoordinator(router: router)
        coordinator.start()
        navigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        return navigationController
    }
    
    private func ordersNC() -> UINavigationController {
        let ordersVC = MyOrdersViewController()
        ordersVC.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(systemName: "truck.box.badge.clock.fill"), tag: 1)
        return UINavigationController(rootViewController: ordersVC)
    }
    
    private func notificationsNC() -> UINavigationController {
        let notificationsVC = NotificationsViewController()
        notificationsVC.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(systemName: "bell"), tag: 2)
        return UINavigationController(rootViewController: notificationsVC)
    }
    
    private func profileNC() -> UINavigationController {
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 3)
        return UINavigationController(rootViewController: profileVC)
    }
}


