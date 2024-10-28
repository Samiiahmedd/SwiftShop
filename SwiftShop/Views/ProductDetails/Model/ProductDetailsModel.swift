//
//  ProductDetailsModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 07/09/2024.
//

import UIKit

// MARK: - NewArrival


struct ProductDetailsModel: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
    
    // MARK: - Rating
    struct Rating: Codable {
        let rate: Double
        let count: Int
    }
}
