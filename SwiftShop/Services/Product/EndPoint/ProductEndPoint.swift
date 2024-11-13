//
//  ProductEndPoint.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 07/11/2024.
//

import Foundation
import NetworkLayer

enum ProductEndPoint: EndPoint {
    
    // MARK: - CASES
    
    case homeProducts
    case productDetails(id: Int)
    
    // MARK: - PROPRITIES
    
    var path: String {
        switch self {
        case .homeProducts:
            "/api/home"
            
        case .productDetails(let id):
            "/api/products/\(id)"
        }
    }
    
    var headers: Headers {
        ["lang": "en"]
    }
    
    var method: HTTPMethod {
        .get
    }
    
  
}

