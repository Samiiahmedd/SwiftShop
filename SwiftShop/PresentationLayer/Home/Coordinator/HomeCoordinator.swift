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
    func displayCart()
    func displayAddAddressScreen()
    func displayAllAdrese()
    func displayPaymentMethods()
    func displayCardEnter()
    func displayWishlist()
}

final class HomeCoordinator {
    
    var router: any Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
         displayWishlist()
//        displayHome()
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
            let productServices = ProductServices()
            let cartServices = CartServices()
            let favouritesServices = FavouritesServices()
            let productDetailsViewModel = ProductDetailsViewModel(
                id: productId,
                services: productServices,
                cartServices: cartServices, favouritesServices: favouritesServices,
                coordinator: self
            )
            let productDetailsVC = ProductDetailsViewController(viewModel: productDetailsViewModel, productId: productId)
            productDetailsVC.coordinator = self
            self.router.push(productDetailsVC)
        }
    }
    
    func displayCart () {
        DispatchQueue.main.async {
            let viewModel = CartViewModel(id: 1, coordinator: self)
            let vc = CartViewController(viewModel: viewModel)
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
    
    func displayAllAdrese() {
        DispatchQueue.main.async {
            let viewModel = ShippingAddressViewModel(coordinator: self)
            let vc = ShippingViewController(viewModel: viewModel)
            vc.coordinator = self
            self.router.push(vc)
        }
    }
    
    func displayAddAddressScreen() {
        DispatchQueue.main.async {
            let viewModel = AddShippingAddressViewModel(coordinator: self)
            let vc = ShippingAddressViewController(viewModel: viewModel)
            vc.coordinator = self
            self.router.push(vc)
        }
    }
    
    func displayPaymentMethods() {
        DispatchQueue.main.async {
            let vm = PaymentMethodViewModel(coordinator: self)
            let vc = PaymentMethodViewController(viewModel: vm)
            vc.coordinator = self
            self.router.push(vc)
        }
    }
    
    func displayCardEnter() {
        DispatchQueue.main.async {
            let vm = CardEnterViewModel(coordinator: self)
            let vc = CardEnterViewController(viewModel: vm)
            vc.coordinator = self
            self.router.push(vc)
        }
    }
    
    func  displayWishlist() {
        DispatchQueue.main.async {
            let vm = WishlistViewModel(id: 0, coordinator: self)
            let vc = WishlistViewController(viewModel: vm)
            vc.coordinator = self
            self.router.push(vc)

        }
    }
}


