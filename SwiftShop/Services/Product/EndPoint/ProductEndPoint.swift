//
//  ProductEndPoint.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 07/11/2024.
//

import Foundation
import NetworkLayer

enum ProductEndPoint: EndPoint {
    // CASES
    
    case products([URLQueryItem])
    case productDetails
    
    // PROPRITIES
    
    var path: String {
        switch self {
        case .products:
            "products"
        case .productDetails:
            ""
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .products(let parms):
            return parms
        case .productDetails:
            return []
        }
    }
}

