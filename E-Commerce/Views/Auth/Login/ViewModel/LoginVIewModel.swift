//
//  LoginVIewModel.swift.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 24/06/1403 AP.
//

import Foundation
import FirebaseAuth
import Combine

@MainActor
protocol LoginViewModelProtocol {
    var isLogin: PassthroughSubject<Bool, Never> { get }
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    func login(with email: String, password: String) async
}

class LoginViewModel {
    var isLogin: PassthroughSubject<Bool, Never> = .init()
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    init() { }
}

extension LoginViewModel: LoginViewModelProtocol {
    func login(with email: String, password: String) async {
        isLoading.send(true)
        do {
            try await FirebaseManager.shared.login(with: email, password: password)
            isLoading.send(false)
            isLogin.send(true)
        } catch {
            isLoading.send(false)
            errorMessage.send(error.localizedDescription)
        }
    }
}
