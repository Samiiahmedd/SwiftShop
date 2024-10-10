//
//  UserDefultsWrapper.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 05/10/2024.
//

import Foundation

@propertyWrapper
public struct UserDefaultsWrapper<T> {
    let key: String
    let defaultValue: T
    
    public var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        } nonmutating set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
