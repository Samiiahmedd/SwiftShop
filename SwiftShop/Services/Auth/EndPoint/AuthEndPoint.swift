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
    case verifyCode
    case resetPassword
    
    
    var path: String {
        switch self {
        case .login:
            "/api/login"
        case .signup:
            "/api/register"
        case .verfiyEmail:
            "/api/verify-email"
        case .verifyCode:
            "/api/verify-code"
        case .resetPassword:
            "/api/reset-password"
        }
    }
    
    var headers: Headers {
        ["lang": "en"]
    }
    
    var method: HTTPMethod {
        .post
    }
}
