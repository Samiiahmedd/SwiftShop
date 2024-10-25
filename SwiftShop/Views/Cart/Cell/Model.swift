//
//  Model.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/09/2024.
//

import Foundation
import UIKit

struct CartProductModel: Codable {
    let productTitle : String
    let productDescription : String
    let productPrice : String
    let productImageName : String
    var productImage: UIImage? {
           return UIImage(named: productImageName)
       }
}


