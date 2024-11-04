//
//  CustomTabBarViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 15/10/2024.
//

import UIKit

class CustomTabBarViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var homeTab: CustomTabButtonView!
    @IBOutlet weak var cartTab: CustomTabButtonView!
    @IBOutlet weak var notificationTab: CustomTabButtonView!
    @IBOutlet weak var profileTab: CustomTabButtonView!
    
    //MARK: - VARIABLES
    
    private var homeVC: UIViewController!
    private var cartVC: UIViewController!
    private var notificationsVC: UIViewController!
    private var profileVC: UIViewController!
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

//MARK: - SETUPVIEW

extension CustomTabBarViewController {
    
    func setupView() {
        setupTabs()
        setupViewControllers()
    }
    
    private func setupTabs() {
        homeTab.configure(image: UIImage(named: "HomeNotSelected")! , name: "Home")
        cartTab.configure(image: UIImage(named: "cartNotSelected")!, name: "Cart")
        notificationTab.configure(image: UIImage(named: "notificationNotSelected")!, name: "Notifications")
        profileTab.configure(image: UIImage(named: "profileNotSelected")!, name: "Profile")
        
        let homeTapGesture = UITapGestureRecognizer(target: self, action: #selector(homeTapped))
        homeTab.addGestureRecognizer(homeTapGesture)
        
        let cartTapGesture = UITapGestureRecognizer(target: self, action: #selector(cartTapped))
        cartTab.addGestureRecognizer(cartTapGesture)
        
        let notificationsTapGesture = UITapGestureRecognizer(target: self, action: #selector(notificationsTapped))
        notificationTab.addGestureRecognizer(notificationsTapGesture)
        
        let profileTapGesture = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
        profileTab.addGestureRecognizer(profileTapGesture)
    }
    
    
    private func setupViewControllers() {
        homeVC = UINavigationController(rootViewController: HomeVC())
        
        cartVC = UINavigationController(rootViewController: CartViewController())
        notificationsVC = UINavigationController(rootViewController: NotificationsViewController())
        profileVC = UINavigationController(rootViewController: ProfileViewController())
    }
    
    private func selectTab(_ selectedTab: CustomTabButtonView) {
        homeTab.isSelectedTab = false
        cartTab.isSelectedTab = false
        notificationTab.isSelectedTab = false
        profileTab.isSelectedTab = false
        selectedTab.isSelectedTab = true
        
        
        switch selectedTab {
        case homeTab:
            switchToViewController(homeVC)
        case cartTab:
            switchToViewController(cartVC)
        case notificationTab:
            switchToViewController(notificationsVC)
        case profileTab:
            switchToViewController(profileVC)
        default:
            break
        }
    }
    
    //MARK: - TAB ACTIONS
    @objc private func homeTapped() {
        selectTab(homeTab)
        switchToViewController(homeVC)
    }
    
    @objc private func cartTapped() {
        selectTab(cartTab)
        switchToViewController(cartVC)
    }
    
    @objc private func notificationsTapped() {
        selectTab(notificationTab)
        switchToViewController(notificationsVC)
    }
    
    @objc private func profileTapped() {
        selectTab(profileTab)
        switchToViewController(profileVC)
    }

    
    private func switchToViewController(_ viewController: UIViewController) {
        for child in children {
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        addChild(viewController)
        viewController.view.frame = containerView.bounds
        containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}
