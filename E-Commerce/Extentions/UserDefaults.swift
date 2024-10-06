//
//  UserDefaults.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 05/10/2024.
//

import Foundation

extension UserDefaults {
    @UserDefaultsWrapper(key: "isUserLogin", defaultValue: nil)
    static var isLogin: Bool?
    
    @UserDefaultsWrapper(key: "isOnBoardingActive", defaultValue: nil)
    static var isOnBoardingActive: Bool?
}
