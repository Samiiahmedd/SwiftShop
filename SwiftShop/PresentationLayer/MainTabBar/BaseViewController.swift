//
//  BaseViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 23/10/2024.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Propertys
    private var loaderIndicator = UIActivityIndicatorView()
    
}

// MARK: - Lifecycle

extension BaseViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabBarController = tabBarController {
            tabBarController.tabBar.isHidden = false
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let tabBarController = tabBarController {
            tabBarController.tabBar.isHidden = false
        }
    }
}

// MARK: - Functions
extension BaseViewController {
    func startLoading() {
        loaderIndicator.style = .medium
        loaderIndicator.color = .gray
        loaderIndicator.startAnimating()
        view.addSubview(loaderIndicator)
        
        loaderIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loaderIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func stopLoading() {
        loaderIndicator.stopAnimating()
        loaderIndicator.removeFromSuperview()
    }
}
