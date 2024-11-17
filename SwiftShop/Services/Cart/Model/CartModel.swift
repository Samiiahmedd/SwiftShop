//
//  CartModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 17/11/2024.
//

import Foundation

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

