////
////  CartManager.swift
////  SwiftShop
////
////  Created by Sami Ahmed on 25/10/2024.
////
//
//import Foundation
//
//class CartManager {
//    static let shared = CartManager()
//    private init() {
//        loadCartItems()
//    }
//
//    private var cartItems: [CartProductModel] = []
//
//    func addToCart(_ product: CartProductModel) {
//        cartItems.append(product)
//        saveCartItems()
//    }
//
//    func getCartItems() -> [CartProductModel] {
//        return cartItems
//    }
//
//    private func saveCartItems() {
//        if let encoded = try? JSONEncoder().encode(cartItems) {
//            UserDefaults.standard.set(encoded, forKey: "cartItems")
//        }
//    }
//
//    private func loadCartItems() {
//        if let savedCartData = UserDefaults.standard.data(forKey: "cartItems"),
//           let savedCartItems = try? JSONDecoder().decode([CartProductModel].self, from: savedCartData) {
//            cartItems = savedCartItems
//        }
//    }
//
//    func clearCart() {
//        cartItems.removeAll()
//        saveCartItems()
//    }
//}
