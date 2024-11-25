//
//  CartViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/09/2024.
//

import Foundation
import Combine
import UIKit

@MainActor
protocol CartViewModelProtocol {
    
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    ///input
    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
    var paymentButtonTriggerd: PassthroughSubject<Void, Never> { get }
}

@MainActor
class CartViewModel {
    
    // MARK: - Properties
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    var paymentButtonTriggerd: PassthroughSubject<Void, Never> = .init()
    
    var id: Int
    private var cancellable = Set<AnyCancellable>()
    var coordinator:HomeCoordinatorProtocol
    private let services: CartServicesProtocol
    var cartItem : [inCartItem] = []
    var inCartData = PassthroughSubject<inCartData, Never>()
    @Published var totalPrice: String = "$0.00"

    // MARK: - Initialization
    
    init(id: Int,services: CartServicesProtocol = CartServices(),
         coordinator: HomeCoordinatorProtocol) {
        self.id = id
        self.services = services
        self.coordinator = coordinator
    }
}

extension CartViewModel: CartViewModelProtocol {
    
    func bindIsCartItems() {
        backActionTriggerd
            .sink { [weak self] _ in self?.coordinator.pop() }
            .store(in: &cancellable)
    }
}

extension CartViewModel {
    
    //Get Cart
    
    func getCart() {
        isLoading.send(true)
        services.getCart()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading.send(false)
            } receiveValue: { [weak self] products in
                self?.cartItem = products.cart_items
                if products.cart_items.isEmpty {
                    self?.errorMessage.send("Your cart is empty. Please add products.")
                }
                self?.inCartData.send(products)
                self?.totalPrice = "$\(products.total)"
            }
            .store(in: &cancellable)
    }
    
    // DELETE
    
    func deleteCartItem(productId: Int) {
        let body = CartBody(product_id: productId)
        isLoading.send(true)
        services.deleteCartItem(with: body)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading.send(false)
                switch completion {
                case .finished:
                    print("Product successfully deleted from the cart.")
                case .failure(let error):
                    self.errorMessage.send(error.localizedDescription)
                }
            } receiveValue: { cartData in
                print("ProductDeleted")
            }
            .store(in: &self.cancellable)
    }
}


