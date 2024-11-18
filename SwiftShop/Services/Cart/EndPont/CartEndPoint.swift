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
        ["lang": "en", "Authorization": "2GRV0WuZ4OKGJN4bDaDSlHmnagjtAOSGa6K9Q7JcVi0QVApVNf9H5CJXOWUvwpQ90awHqm"]
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

