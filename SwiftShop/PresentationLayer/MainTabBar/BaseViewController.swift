//
//  BaseViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 23/10/2024.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBarController = tabBarController {
            tabBarController.tabBar.isHidden = false // Show the tab bar by default
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let tabBarController = tabBarController {
            tabBarController.tabBar.isHidden = false // Ensure the tab bar is shown when leaving
        }
    }
}
