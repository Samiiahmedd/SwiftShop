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
    func gotToCartTab()
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
            cartNC(),
            notificationsNC(),
            profileNC()
        ]
        let tabBar = MainTabBarViewController(controllers: tabBarControllers)
        router.push(tabBar)
    }
    
//    func homeViewController() -> UIViewController {
//        let navigationController = UINavigationController()
//        let router = AppRouter(navigationController: navigationController)
//        let coordinator = HomeCoordinator(router: router)
//        coordinator.start()
//        return navigationController
//    }
    func homeNC() -> UINavigationController {
        let mainVC = HomeVC()
        mainVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        return UINavigationController(rootViewController: mainVC)
    }
    
    func cartNC() -> UINavigationController {
        let cartVC        = CartViewController()
        cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), tag: 1)
        
        return UINavigationController(rootViewController: cartVC)
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

    
//    func conversationsViewController() -> UIViewController {
//        let navigationController = UINavigationController()
//        let router = AppRouter(navigationController: navigationController)
//        let coordinator = ConversationsCoordinator(router: router)
//        coordinator.start()
//        return navigationController
//    }
//    
//    func myBookingViewController() -> UIViewController {
//        let navigationController = UINavigationController()
//        return navigationController
//    }
//    
//    func profileViewController() -> UIViewController {
//        let navigationController = UINavigationController()
//        let router = AppRouter(navigationController: navigationController)
//        let coordinator = ProfileCoordinator(router: router)
//        coordinator.start()
//        return navigationController
//    }
}

extension TabBarCoordinator: TabBarCoordinatorProtocol {
    func goToHomeTab() {
//        tabBar?.selectedIndex = 0
    }
    
    func gotToCartTab() {
//        tabBar?.selectedIndex = 1
    }
    
    func goToNotificationsTab() {
//        tabBar?.selectedIndex = 2
    }
    
    func goToProfileTab() {
//        tabBar?.selectedIndex = 3 b
    }
}
