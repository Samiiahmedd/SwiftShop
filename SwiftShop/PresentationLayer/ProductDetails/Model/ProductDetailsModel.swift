////
////  ProductDetailsModel.swift
////  E-Commerce
////
////  Created by Sami Ahmed on 07/09/2024.
////
//
//import UIKit
//import CoreData
//
//
//struct ProductDetailsModel: Codable {
//    let id: Int32
//    let title: String
//    let price: Double
//    let description: String
//    let category: String
//    let image: String
//    let rating: Rating
//    
//    struct Rating: Codable {
//        let rate: Double
//        let count: Int
//    }
//    
//    init(from favouritProduct: WishlistProduct) {
//        
//        self.title = favouritProduct.title!
//        self.id = favouritProduct.id
//        self.price = favouritProduct.price
//        self.description = favouritProduct.desc!
//        self.image = favouritProduct.image!
//        self.rating = Rating(rate: 3, count: 1)
//        self.category = favouritProduct.category!
//        }
//
//}
