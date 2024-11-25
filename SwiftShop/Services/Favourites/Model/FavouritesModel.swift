//
//  FavouritesModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 25/11/2024.
//

import Foundation

//ADD TO FAVOURITES

struct FavouritesBody: Codable {
    let product_id : Int
}

struct FavouritesData: Codable {
    let id: Int
    let product: FavouritesProduct
}

struct FavouritesProduct: Codable {
    let id: Int
    let price: Double
    let old_price: Double
    let discount: Int
    let image: String
}

//IN FAVOURITES

struct inFavouritesData: Codable {
    let data : [inFavouritesItem]
}

struct inFavouritesItem: Codable {
    let id: Int
    let product: inFavouritesProduct
}

struct inFavouritesProduct: Codable {
    let id: Int
     let price: Double
     let old_price: Double
     let discount: Int
     let image: String
     let name: String
     let description: String
}

