//
//  CartEndPoint.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 17/11/2024.
//

import Foundation
import NetworkLayer

enum CartEndPoint: EndPoint {
    
    // MARK: - CASES
    
    case addProduct
    case getCart
    case deleteCartItem
    
    // MARK: - PROPERTIES
    
    var path: String {
        switch self {
        case .addProduct:
            return "/api/carts"
        case .getCart:
            return "/api/carts"
        case .deleteCartItem:
            return "/api/carts"
        }
    }
    
    var headers: Headers {
        let userToken: String = UserDefaults.standard.value(forKey: "userToken") as! String
        return [
            "lang": "en",
            "Authorization": userToken
        ]
    }
    
    var method: HTTPMethod {
        switch self {
        case .addProduct:
            return  .post
        case .getCart:
            return .get
        case .deleteCartItem:
            return .post
        }
    }
}

