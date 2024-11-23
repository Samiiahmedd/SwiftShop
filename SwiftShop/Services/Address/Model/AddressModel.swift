//
//  AddressModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 23/11/2024.
//

import Foundation
struct Data: Codable {
    let data : [AddressData]
}
struct AddressData: Codable,Equatable {
    let id: Int
    let name: String
    let city: String
    let region: String
    let details: String
    let notes: String
    let latitude: Double
    let longitude: Double
}

struct AddressBody: Codable {
    let name: String
    let city: String
    let region: String
    let details: String
    let latitude: Double?
    let longitude: Double?
    let notes: String
    
    func validate() -> (isValid: Bool, errorMessage: String?) {
        if [name,city,region,details,notes ].contains(where: { $0.isEmpty }) {
            return (false, "Please fill in all required fields.")
        }
        return (true, nil)
    }
}
