//
//  CartViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/09/2024.
//

import Foundation
import Combine

@MainActor
protocol CartViewModelProtocol {
    
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    func fetchCartItems() -> [CartProduct]
    func addProductToCart(_ product: CartProduct)
    func removeProductFromCart(at index: Int)
    
}

@MainActor
class CartViewModel:CartViewModelProtocol{
    
    // MARK: - Properties

    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    private var cancellable = Set<AnyCancellable>()
    private let services: CartServicesProtocol
    private let productId: Int
    private(set) var cartItems: [CartProduct] = []
    
    // MARK: - Initialization
    
    init(services: CartServicesProtocol, productId: Int) {
        self.services = services
        self.productId = productId
    }
    

    
    func fetchCartItems() -> [CartProduct] {
        return cartItems
    }
    
    func addProductToCart(_ product: CartProduct) {
        cartItems.append(product)
    }
    
    func removeProductFromCart(at index: Int) {
        guard index >= 0 && index < cartItems.count else { return }
        cartItems.remove(at: index)
    }

//        func calculateCartTotals() {
//            subtotal = cartItems.reduce(0) { $0 + $1.product.price * Double($1.quantity) }
//            totalAmount = subtotal - (subtotal * 0.1)  // Assuming a 10% discount
//            numberOfItems = cartItems.reduce(0) { $0 + $1.quantity }
//        }
}
