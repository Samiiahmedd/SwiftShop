//
//  FirebaseManager.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 25/06/1403 AP.
//

import Foundation
import FirebaseAuth

protocol FirebaseAuthService {
    func login(with email: String, password: String) async throws
    func signup(with email: String, password: String) async throws
}

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    let manager = Auth.auth()
    private init() { }
}

extension FirebaseManager: FirebaseAuthService {
    func login(with email: String, password: String) async throws {
        do {
            let user = try await Auth.auth().signIn(withEmail: email, password: password)
            print(user)
        } catch {
            throw error
        }
    }
    
    func signup(with email: String, password: String) async throws {
        do {
            let user = try await Auth.auth().createUser(withEmail: email, password: password)
            print(user)
        } catch {
            throw error
        }
    }
}
