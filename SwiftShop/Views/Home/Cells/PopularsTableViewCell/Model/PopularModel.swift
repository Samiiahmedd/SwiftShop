//
//  PopularModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 04/09/2024.
//

import Foundation
import UIKit


struct PopularModel: Codable {
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
