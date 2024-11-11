//
//  ProductModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 07/11/2024.
//

import Foundation

struct HomeData: Codable {
    let banners: [Banner]
    let products: [Product]
    let ad: String?
}

struct Banner: Codable {
    let id: Int
    let image: String
    let category: String?
    let product: String?
}

struct Product: Codable {
    let id: Int
    let price: Double
    let old_price: Double
    let discount: Double
    let image: String
    let name: String
    let description: String
    let images: [String]
    let in_favorites: Bool
    let in_cart: Bool
}
 

