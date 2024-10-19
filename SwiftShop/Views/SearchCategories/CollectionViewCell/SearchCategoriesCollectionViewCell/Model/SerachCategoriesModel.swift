//
//  SerachCategoriesModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/09/2024.
//

import Foundation

struct CategoriesResponse: Codable {
    let data : [Category]
}

struct Category : Codable {
    let _id: String?
    let name: String
    let image: String
}
