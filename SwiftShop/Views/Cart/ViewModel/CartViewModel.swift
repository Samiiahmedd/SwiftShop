//
//  CartViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/09/2024.
//

import Foundation

class CartViewModel {
    
    private(set) var CartItems: [CartProductModel] = []
    
    init() {
        loadCartItems()
    }
    
    func addToCart(_ product: CartProductModel) {
        CartItems.append(product)
        saveCartItems()
    }
    
    func removeFromCart(at index: Int) {
        guard index < CartItems.count else { return }
        CartItems.remove(at: index)
        saveCartItems()
    }
    
    private func saveCartItems() {
        if let encodedData = try? JSONEncoder().encode(CartItems) {
            UserDefaults.standard.set(encodedData, forKey: "cartItems")
        }
    }
    
    private func loadCartItems() {
        if let savedData = UserDefaults.standard.data(forKey: "cartItems"),
           let decodedItems = try? JSONDecoder().decode([CartProductModel].self, from: savedData) {
            CartItems = decodedItems
        }
    }
}

