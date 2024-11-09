//
//  UserModel.swift
//  SwiftShop
//
//  Created by Abdalazem Saleh on 09/11/2024.
//

import Foundation

// MARK: - MODEL

struct UserModel: Codable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let image: String
    let points: Float
    let credit: Float
    let token: String
}

// MARK: - LOGIN BODY

struct LoginBody: Codable {
    let email: String
    let password: String

    func isValid() -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            return false
        }
        return true
    }
}

// MARK: - SIGNUP BODY

struct SignupBody: Codable {
    let name: String
    let phone: String
    let email: String
    let password: String
    
    func isValid() -> Bool {
        guard !name.isEmpty, !phone.isEmpty, !email.isEmpty, !password.isEmpty else {
            return false
        }
        return true
    }
}
