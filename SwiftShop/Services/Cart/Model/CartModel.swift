//
//  CartModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 17/11/2024.
//

import Foundation

//ADD TO CART

struct CartBody: Codable {
    let product_id : Int
}

struct CartData: Codable {
    let id: Int
    let quantity: Int
    let product: CartProduct
}

struct CartProduct: Codable {
    let id: Int
    let price: Double
    let old_price: Double
    let discount: Int
    let image: String
}

//IN CART

struct inCartData: Codable {
    let cart_items: [inCartItem]
    let sub_total: Double
    let total: Double
}

struct inCartItem: Codable {
    let id: Int
    let quantity: Int
    let product: inCartProduct 
}

struct inCartProduct: Codable {
    let id: Int
    let price: Double
    let old_price: Double
    let discount: Int
    let image: String
    let name: String
    let description: String
    let images: [String]
    let in_favorites: Bool
    let in_cart: Bool
}

