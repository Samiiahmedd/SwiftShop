//
//  OrderEndPoint.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 23/11/2024.
//

import Foundation
import NetworkLayer

enum OrderEndPoint: EndPoint {
    case placeOrder
    
    var path: String {
        switch self {
        case .placeOrder:
            return "/api/orders"
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
        case .placeOrder:
            return .post
        }
    }
}
