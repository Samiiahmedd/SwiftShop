//
//  AuthEndPoint.swift
//  SwiftShop
//
//  Created by Abdalazem Saleh on 09/11/2024.
//

import Foundation
import NetworkLayer

enum AuthEndPoint: EndPoint {
    case login
    case signup
    case verfiyEmail
    case resetPassword
    
    var path: String {
        switch self {
        case .login:
//            "/api/login"
            "/auth/login"
        case .signup:
            ""
        case .verfiyEmail:
            ""
        case .resetPassword:
            ""
        }
    }
    
    var headers: Headers {
        ["lang": "en"]
    }
    
    var method: HTTPMethod {
        .post
    }
}
