//
//  UserDefaultsManager.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 24/10/2024.
//

import Foundation
//
//struct UserDefaultsManager {
//    
//    private let addressKey = "savedAddresses"
//    
//    func saveAddresses(_ addresses: [Address]) {
//        let encoder = JSONEncoder()
//        if let encoded = try? encoder.encode(addresses) {
//            UserDefaults.standard.set(encoded, forKey: addressKey)
//        }
//    }
//    
//    func loadAddresses() -> [Address] {
//        if let savedAddresses = UserDefaults.standard.data(forKey: addressKey) {
//            let decoder = JSONDecoder()
//            if let loadedAddresses = try? decoder.decode([Address].self, from: savedAddresses) {
//                return loadedAddresses
//            }
//        }
//        return []
//    }
//}
