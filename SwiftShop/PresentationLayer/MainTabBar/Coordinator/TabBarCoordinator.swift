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
        router.push(tabBar)
    }
    
    
    func homeNC() -> UINavigationController {
        let mainVC = HomeVC()
        mainVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        return UINavigationController(rootViewController: mainVC)
    }
    
    func ordersNC() -> UINavigationController {
        let ordersVC        = MyOrdersViewController()
        ordersVC.tabBarItem = UITabBarItem(title: "Orders", image: UIImage(systemName: "cart.badge.clock"), tag: 1)
        return UINavigationController(rootViewController: ordersVC)
    }
    
    func notificationsNC() -> UINavigationController {
        let notificationsVC = NotificationsViewController()
        notificationsVC.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(systemName: "bell"), tag: 2)
        
        return UINavigationController(rootViewController: notificationsVC)
    }
        
    func profileNC() -> UINavigationController {
        let profileVC        = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 3)
        
        
        return UINavigationController(rootViewController: profileVC)
    }
}

extension TabBarCoordinator: TabBarCoordinatorProtocol {
    func gotToOrdersTab() {
        
    }
    
    func goToHomeTab() {
//        tabBar?.selectedIndex = 0
    }
    
    
    func goToNotificationsTab() {
//        tabBar?.selectedIndex = 2
    }
    
    func goToProfileTab() {
//        tabBar?.selectedIndex = 3 b
    }
}