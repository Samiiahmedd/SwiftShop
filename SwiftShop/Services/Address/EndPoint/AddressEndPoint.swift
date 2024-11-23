//
//  AddressEndPoint.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 23/11/2024.
//

import Foundation
import NetworkLayer

enum AddressEndPoint: EndPoint{
    
    // MARK: - CASES
    
    case addAddress
    case getAddress
    
    // MARK: - PROPERTIES
    
    var path: String {
        switch self {
        case .addAddress:
            "/api/addresses"
        case .getAddress:
            "/api/addresses"
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
        case .addAddress:   
            return .post
        case .getAddress:
            return .get
        }
    }
}
