//
//  BaseModel.swift
//  SwiftShop
//
//  Created by Abdalazem Saleh on 09/11/2024.
//

import Foundation

struct BaseModel<T: Codable>: Codable {
    let status: Bool
    let message: String
    let data: T?
}
