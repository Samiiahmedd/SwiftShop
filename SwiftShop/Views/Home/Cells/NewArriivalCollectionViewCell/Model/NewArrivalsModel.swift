//
//  NewArrivalsModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/10/2024.
//

import Foundation

struct NewArrivalsModel : Codable {
    let status: String?
    let data : [NewArrivals]
}

struct NewArrivals:Codable{
    let _id: String?
    let title: String
    let price: Double
    let description: String
}
