//
//  OrderModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 23/11/2024.
//

import Foundation

struct OrderBody: Codable {
    let address_id: Int
    let payment_method: Int
    let use_points: Bool
    let promo_code_id: Int?
}

struct OrderResponse: Codable {
    let data: OrderData?
}

struct OrderData: Codable {
    let payment_method: String
    let cost: Double?
    let vat: Double?
    let discount: Double?
    let points: Double?
    let total: Double?
    let id: Int
}
