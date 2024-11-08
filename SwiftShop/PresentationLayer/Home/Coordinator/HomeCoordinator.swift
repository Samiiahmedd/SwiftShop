    //
    //  HomeCoordinator.swift
    //  SwiftShop
    //
    //  Created by Abdalazem Saleh on 26/10/2024.
    //

    import UIKit

    protocol HomeCoordinatorProtocol: Coordinator {
        func displayHome()
        func displayNewArrivals()
        func displayAllNewArrivals()
        func displayPopulars()
        func displayAllPopulars()
        func displayProductDetailsByProductId()
        func displaySearchScreen()
        func displayCategoriesScreen()
        func displayCategoryScreenByCategortId()
        func displayAddToCartAlert()
        func displayAddToWishlistAlert()
        func backToHome()
    }

    final class HomeCoordinator {
        
        var router: any Router
        
        init(router: Router) {
            self.router = router
        }
        
        func start() {
        
        }
    }


