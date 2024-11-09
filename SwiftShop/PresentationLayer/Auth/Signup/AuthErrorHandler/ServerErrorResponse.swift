//
//  Model.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 09/11/2024.
//

import Foundation

struct ServerErrorResponse: Codable {
    let errors: [ErrorDetail]
}

struct ErrorDetail: Codable {
    let msg: String
    let path: String
}
