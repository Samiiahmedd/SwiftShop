//
//  Constants.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 30/09/2024.
//

import Foundation

struct Constants {
    static let baseURL = "https://full-e-commerce-rest-ful-api-s.vercel.app"
}

enum APIError : Error {
    case failedTogetData
    case faildToUpload
    case invalidUrl
}
