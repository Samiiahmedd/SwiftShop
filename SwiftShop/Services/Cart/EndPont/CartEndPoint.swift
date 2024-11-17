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
    
    // MARK: - PROPERTIES
    
    var path: String {
        switch self {
        case .addProduct:
            return "/api/carts"
        }
    }
    
    var headers: Headers {
        ["lang": "en", "Authorization": "H8AwrN0jaUXvbhEx1NsgqeufvtWGieIPFHrUe3MJtfae6x8xUKbrwxBTKETXIUyeFEvZAa"]
    }
    
    var method: HTTPMethod {
        .post
    }
}

