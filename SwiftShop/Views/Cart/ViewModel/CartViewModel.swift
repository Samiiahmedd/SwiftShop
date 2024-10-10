//
//  CartViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/09/2024.
//

import Foundation
import UIKit

class CartViewModel {
    var CartItems : [CartProductModel] = [
        .init(productImage: UIImage(named: "staper")!,
              productTitle: "On Ear Headphone",
              productDescription: "Beats Solo3 Wireless Kulak",
              productPrice: "$40.00"),
        
        .init(productImage: UIImage(named: "staper")!,
              productTitle: "On Ear Headphone",
              productDescription: "Beats Solo3 Wireless Kulak",
              productPrice: "$40.00"),
        
        .init(productImage: UIImage(named: "six")!,
              productTitle: "On Ear Headphone",
              productDescription: "Beats Solo3 Wireless Kulak",
              productPrice: "$40.00"),
        
        .init(productImage: UIImage(named: "six")!,
              productTitle: "On Ear Headphone",
              productDescription: "Beats Solo3 Wireless Kulak",
              productPrice: "$40.00")
    ]
}
