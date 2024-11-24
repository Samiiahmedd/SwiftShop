//
//  ProductModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 07/11/2024.
//

protocol ProductDisplayable {
    var id: Int { get }
    var price: Double { get }
    var old_price: Double { get }
    var discount: Double { get }
    var image: String { get }
    var name: String { get }
    var description: String { get }
    var images: [String] { get }
    var in_favorites: Bool { get }
    var in_cart: Bool { get }
}


//HOME

struct HomeData: Codable {
    let banners: [Banner]
    let products: [Product]
    let ad: String?
}

struct Banner: Codable {
    let id: Int
    let image: String
    let category: Categories?
    let product: String?
}

struct Categories: Codable {
    let id: Int
    let image: String
    let name: String
}

struct Product: Codable, ProductDisplayable {
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

//PRODUCT DETAILS

struct ProductDetails: Codable {
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
