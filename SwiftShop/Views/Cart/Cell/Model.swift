//
//  Model.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/09/2024.
//

import Foundation

// MARK: - CartResponse
struct CartResponse: Decodable {
    let id: Int
    let userId: Int
    let date: String // Use String to keep the original format; consider parsing to Date later
    let products: [CartProduct]
}

// MARK: - CartProduct
struct CartProduct: Decodable {
    let productId: Int
    let quantity: Int
}

struct CartProductItem {
    let cartProduct: CartProduct
    let productDetails: PopularModel // Use the Product struct you already have
}


