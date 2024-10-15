//
//  CustomTabBarViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 15/10/2024.
//

import UIKit

class CustomTabBarViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var homeTab: CustomTabButtonView!
    @IBOutlet weak var cartTab: CustomTabButtonView!
    @IBOutlet weak var notificationTab: CustomTabButtonView!
    @IBOutlet weak var profileTab: CustomTabButtonView!
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
    setupView()
    }
    
    @objc private func homeTapped() {
            selectTab(homeTab)
            // Navigate to Home ViewController here
        }
        
        @objc private func cartTapped() {
            selectTab(cartTab)
            // Navigate to Cart ViewController here
        }
        
        @objc private func notificationsTapped() {
            selectTab(notificationTab)
            // Navigate to Notifications ViewController here
        }
        
        @objc private func profileTapped() {
            selectTab(profileTab)
            // Navigate to Profile ViewController here
        }
}

//MARK: - SETUPVIEW
extension CustomTabBarViewController {
    
    func setupView() {
        setupTabs()
        selectTab(homeTab)
        applyTopCornerRadius()
    }
    private func setupTabs() {
        homeTab.configure(image: UIImage(named: "HomeNotSelected")! , name: "Home")
            cartTab.configure(image: UIImage(named: "cartNotSelected")!, name: "Cart")
            notificationTab.configure(image: UIImage(named: "notificationNotSelected")!, name: "Notifications")
            profileTab.configure(image: UIImage(named: "profileNotSelected")!, name: "Profile")
            
            // Add tap gestures
            let homeTapGesture = UITapGestureRecognizer(target: self, action: #selector(homeTapped))
            homeTab.addGestureRecognizer(homeTapGesture)
            
            let cartTapGesture = UITapGestureRecognizer(target: self, action: #selector(cartTapped))
            cartTab.addGestureRecognizer(cartTapGesture)
            
            let notificationsTapGesture = UITapGestureRecognizer(target: self, action: #selector(notificationsTapped))
            notificationTab.addGestureRecognizer(notificationsTapGesture)
            
            let profileTapGesture = UITapGestureRecognizer(target: self, action: #selector(profileTapped))
            profileTab.addGestureRecognizer(profileTapGesture)
        }
    
    private func selectTab(_ selectedTab: CustomTabButtonView) {
            // Deselect all tabs first
            homeTab.isSelectedTab = false
            cartTab.isSelectedTab = false
            notificationTab.isSelectedTab = false
            profileTab.isSelectedTab = false
            
            // Select the clicked tab
            selectedTab.isSelectedTab = true
        }
    private func applyTopCornerRadius() {
            // Adding corner radius to the top corners only
            self.mainView.layer.cornerRadius = 35
            self.mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // Top left and top right corners
            self.mainView.clipsToBounds = true
            
            // Optionally, add shadow for better visibility
            self.mainView.layer.shadowColor = UIColor.black.cgColor
            self.mainView.layer.shadowOpacity = 0.2
            self.mainView.layer.shadowOffset = CGSize(width: 0, height: -2)
            self.mainView.layer.shadowRadius = 10
        }


}
