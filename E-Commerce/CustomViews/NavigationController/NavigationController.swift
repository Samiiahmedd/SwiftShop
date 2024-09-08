//
//  NavigationController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 18/07/2024.
//

import Foundation
import UIKit
class GFNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
    }
    func setUpNavigationController() {
//        if UserDefaults().hasOnboarded == true {
//            self.viewControllers = [LoginVC()]
//        }
//        else {
            self.viewControllers = [CartViewController()]
//        }
    }
}
