//
//  LoginModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 30/09/2024.
//

import Foundation

struct User: Codable {
    let status: String
    let data: UserData
}

struct UserData: Codable {
    let user: UserDetails
    let tokens: Tokens
}

struct UserDetails: Codable {
    let id: String
    let name: String
    let email: String
    let photo: String
}

struct Tokens: Codable {
    let accessToken: String
    let refreshToken: String
}
