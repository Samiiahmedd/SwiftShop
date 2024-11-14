//
//  HomeCoordinator.swift
//  SwiftShop
//
//  Created by Abdalazem Saleh on 26/10/2024.
//

import UIKit

protocol HomeCoordinatorProtocol: Coordinator {
    func displayHome()
    func displayProductDetailsScreen(productId: Int)
    func displaySearchScreen()
    func displayCategoriesScreen()
    func displayAddToWishlistAlert()
    func backToHome()
    func displayAllProducts()
}

final class HomeCoordinator {
    
    var router: any Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        displayHome()
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    func displayHome() {
        DispatchQueue.main.async {
            let viewModel = HomeViewModel(coordinator: self)
            let homeVC = HomeVC(viewModel: viewModel)
            homeVC.coordinator = self
            homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
            self.router.push(homeVC)
        }
    }
    
    
    func displayProductDetailsScreen(productId: Int) {
        DispatchQueue.main.async {
            let productDetailsViewModel = ProductDetailsViewModel(id: productId, coordinator: self)
            let productDetailsVC = ProductDetailsViewController(viewModel: productDetailsViewModel, productId: productId)
            productDetailsVC.coordinator = self
            self.router.push(productDetailsVC)
        }
    }


    
    func displaySearchScreen() {
        DispatchQueue.main.async {
            let vc = FilterViewController()
            self.router.push(vc)
        }
        
    }
    
    func displayCategoriesScreen() {
        DispatchQueue.main.async {
            let categoriesViewModel = SearchCategoriesViewModel(coordinator: self)
            let vc = SearchCategoriesViewController(viewModel: categoriesViewModel)
            vc.coordinator = self
            self.router.push(vc)
        }
    }
    
    func displayAddToWishlistAlert() {
        
    }
    
    func backToHome() {
        
    }
    
    func displayAllProducts() {
        DispatchQueue.main.async {
            let viewModel = ProductCollectionViewModel(coordinator: self)
            let vc = ProductCollectionViewController(viewModel: viewModel)
            vc.coordinator = self
            self.router.push(vc)
        }
        
    }
}


