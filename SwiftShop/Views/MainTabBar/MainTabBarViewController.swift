//
//  MainTabBarViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 30/08/2024.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .black
        viewControllers = [homeNC(), cartNC(), notificationsNC(), profileNC()]
    }

    
    func homeNC() -> UINavigationController {
        let mainVC = HomeVC()
        mainVC.title      = "Home"
        mainVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        return UINavigationController(rootViewController: mainVC)
    }
    
    func cartNC() -> UINavigationController {
        let cartVC        = CartViewController()
        cartVC.title      = "Cart"
        cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), tag: 1)
        
        return UINavigationController(rootViewController: cartVC)
    }
    
    func notificationsNC() -> UINavigationController {
        let notificationsVC = NotificationsViewController()
        notificationsVC.title      = "Notifications"
        notificationsVC.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(systemName: "bell"), tag: 2)
        
        return UINavigationController(rootViewController: notificationsVC)
    }
        
    func profileNC() -> UINavigationController {
        let profileVC        = ProfileViewController()
        profileVC.title      = "Profile"
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 3)
        
        return UINavigationController(rootViewController: profileVC)
    }
}
