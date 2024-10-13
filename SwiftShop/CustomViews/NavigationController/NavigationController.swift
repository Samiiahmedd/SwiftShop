//
//  NavigationController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 18/07/2024.
//

import Foundation
import UIKit

class GFNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()

        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        setupNavBar()
    }
    
    func setupNavBar() {
        let navigationBar = self.navigationBar
        navigationBar.backgroundColor = UIColor.clear
        navigationBar.isTranslucent = true
        
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.title = ""
    }
    
    func setUpNavigationController() {
        let isLogin = UserDefaults.isLogin ?? false
        if isLogin {
            self.viewControllers = [HomeVC()]
        } else {
//            let coordinator = AuthCoordinator(navigationController: self)
//            coordinator.start()
            self.viewControllers = [ProductDetailsViewController()]
        }
    }
}
