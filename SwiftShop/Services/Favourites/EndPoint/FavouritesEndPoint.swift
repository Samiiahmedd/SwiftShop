//
//  FavouritesEndPoint.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 25/11/2024.
//

import Foundation
import NetworkLayer

enum FavouritesEndPoint: EndPoint {
    
    //MARK: - CASES
    
    case addProductToFavourites
    case GetFavourites
    case DeleteFavourites
    
    // MARK: - PROPERTIES
    
    var path: String {
        switch self {
        case .addProductToFavourites:
            return "/api/favorites"
        case .GetFavourites:
            return "/api/favorites"
        case .DeleteFavourites:
            return "/api/favorites"
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
        case .addProductToFavourites:
            return  .post
        case .GetFavourites:
            return .get
        case .DeleteFavourites:
            return .post
            
        }
    }
}

