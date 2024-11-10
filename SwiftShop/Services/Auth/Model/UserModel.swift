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
    let points: Float?
    let credit: Float?
    let token: String
}

// MARK: - LOGIN BODY

struct LoginBody: Codable {
    let email: String
    let password: String
    
    func validate() -> (isValid: Bool, errorMessage: String?) {
        if [email, password].contains(where: { $0.isEmpty }) {
            return (false, "Please fill in all required fields.")
        }
        
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: email) {
            return (false, "Please enter a valid email address.")
        }
        return (true, nil)
    }
}
    


// MARK: - SIGNUP BODY

struct SignupBody: Codable {
    let name: String
    let phone: String
    let email: String
    let password: String
    
    func validate() -> (isValid: Bool, errorMessage: String?) {
        if [name, phone, email, password].contains(where: { $0.isEmpty }) {
            return (false, "Please fill in all required fields.")
        }
        
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        if !emailPredicate.evaluate(with: email) {
            return (false, "Please enter a valid email address.")
        }
        return (true, nil)
    }
}


// MARK: - VERIFY EMAIL BODY

struct VerifyEmailBody: Codable {
    let email: String
    
    func isValid() -> Bool {
        guard !email.isEmpty else {
            return false
        }
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

// MARK: - VERIFY CODE

struct VerifyCodeBody: Codable {
    let email: String
    let code: String
}

// MARK: - VERIFY CODE

struct ResetPasswordBody: Codable {
    let email: String
    let code: String
    let password: String
}






