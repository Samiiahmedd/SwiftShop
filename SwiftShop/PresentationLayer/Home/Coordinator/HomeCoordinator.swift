    //
    //  HomeCoordinator.swift
    //  SwiftShop
    //
    //  Created by Abdalazem Saleh on 26/10/2024.
    //

    import UIKit

    protocol HomeCoordinatorProtocol: Coordinator {
        func displayHome()
        func displayProductDetailsScreen()
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
            let vc = HomeVC(viewModel: viewModel)
            vc.coordinator = self
            vc.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
            self.router.push(vc)
        }
    }
    
    
    func displayProductDetailsScreen() {
        DispatchQueue.main.async {
            let productDetailsViewModel = ProductDetailsViewModel(id: 12, coordinator: self) // Initialize your ViewModel
            let vc = ProductDetailsViewController(viewModel: productDetailsViewModel, productId: 123)
            vc.coordinator = self
            self.router.push(vc)
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
            let vc = SearchCategoriesViewController()
            self.router.push(vc)
        }
    }
    
    func displayAddToWishlistAlert() {
        
    }
    
    func backToHome() {
        
    }
    
    func displayAllProducts() {
        
    }
}
    

