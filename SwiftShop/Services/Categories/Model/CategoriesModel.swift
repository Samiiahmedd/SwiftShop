//
//  CategoriesMdodel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 13/11/2024.
//

import Foundation

//GET ALL CATEGORIES DETAILS

struct CategoryResponse: Codable {
    let data: CategoryData
}

struct CategoryData: Codable {
    let data: [Category]
}

struct Category: Codable {
    let id: Int
    let name: String
    let image: String
}

//GET SPECIFIC CATEGORY

import Foundation

struct CategoryProductResponse: Codable {
    let data: CategoryProductData
}

struct CategoryProductData: Codable {
    let data: [CategoryProduct]
}

struct CategoryProduct: Codable,ProductDisplayable {
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

