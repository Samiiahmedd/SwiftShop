//
//  ProductDetailsViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 07/09/2024.
//

import Foundation
import UIKit
import Combine

@MainActor
protocol ProductDetailsViewModelProtocol {
    
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    var showProducts : PassthroughSubject<String,Never> { get }
    
    /// input
    var addToCartButtonActionTriggered: PassthroughSubject<Void, Never> { get }
    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
    
}

@MainActor
class ProductDetailsViewModel {
    
    private let services: ProductServicesProtocol
    private let cartServices: CartServicesProtocol
    private let favouritesServices: FavouritesServicesProtocol
    private var cancellable = Set<AnyCancellable>()
    
    var sizes : [SizeModel] = [
        .init(size: "S"),
        .init(size: "M"),
        .init(size: "L"),
        .init(size: "XL"),
        .init(size: "XXL")
    ]
    var colors: [UIColor] = [.red, .black, .lightGray, .green, .orange]
    var images: [String] = []
    var id: Int
    var ProductDetails = PassthroughSubject<ProductDetails, Never>()
    private(set) var cartItems: [CartProduct] = []
    
    
    var coordinator:HomeCoordinatorProtocol?
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    var showProducts : PassthroughSubject<String,Never> = .init()
    var addToCartButtonActionTriggered: PassthroughSubject<Void, Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    
    init(id: Int, services: ProductServicesProtocol, cartServices:CartServicesProtocol,favouritesServices:FavouritesServicesProtocol, coordinator: HomeCoordinatorProtocol) {
        self.id = id
        self.services = services
        self.cartServices = cartServices
        self.favouritesServices = favouritesServices
        self.coordinator = coordinator
    }
}

extension ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    
    func bindIsProductDetailsHome() {
        backActionTriggerd
            .sink { [weak self] _ in self?.coordinator!.pop() }
            .store(in: &cancellable)
    }
}

extension ProductDetailsViewModel {
    func getProductDetails() {
        isLoading.send(true)
        services.getProductDetails(id: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading.send(false)
                switch completion {
                case .finished:
                    print("Finished fetching product details")
                case .failure(let error):
                    self.errorMessage.send(error.localizedDescription)
                }
            } receiveValue: { [weak self] productDetails in
                self?.images = productDetails.images
                self?.ProductDetails.send(productDetails)
            }
            .store(in: &cancellable)
    }
    
    func addProductToCart() {
        
        let body = CartBody(product_id: id)
        isLoading.send(true)
        cartServices.addProductToCart(with: body)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading.send(false)
                switch completion {
                case .finished:
                    print("Product successfully added to the cart.")
                case .failure(let error):
                    self.errorMessage.send(error.localizedDescription)
                }
            } receiveValue: { cartData in
                AlertViewController.showAlert(on: UIViewController.init(), image:UIImage(systemName: "cart.fill")! , title: "Added To Cart", message: "product added to cart", buttonTitle: "OK") {
                }
            }
            .store(in: &self.cancellable)
    }
    
    func addProductToFavourites() {
        
        let body = FavouritesBody(product_id: id)
        isLoading.send(true)
        favouritesServices.addProductToFavourites(with: body)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading.send(false)
                switch completion {
                case .finished:
                    print("Product successfully added to the cart.")
                case .failure(let error):
                    self.errorMessage.send(error.localizedDescription)
                }
            } receiveValue: { cartData in
                AlertViewController.showAlert(on: UIViewController.init(), image:UIImage(systemName: "cart.fill")! , title: "Added To Cart", message: "product added to Favourites", buttonTitle: "OK") {
                }
            }
            .store(in: &self.cancellable)
    }

    
}
