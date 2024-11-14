//
//  CategoriesEndPoint.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 13/11/2024.
//

import Foundation
import NetworkLayer

enum CategoriesEndPoint: EndPoint {
    
    //MARK: - CASES
    case getAllCategories
    case getCategoryDetails(id: Int)
    
    // MARK: - PROPRITIES

    var path: String {
        switch self {
        case.getAllCategories:
            "/api/categories"
        case .getCategoryDetails(let id):
            "/api/categories/\(id)"
        }
        
        
        
    }
    
    var headers: Headers {
        ["lang": "en"]
    }
    
    var method: HTTPMethod {
        .get
    }
}
