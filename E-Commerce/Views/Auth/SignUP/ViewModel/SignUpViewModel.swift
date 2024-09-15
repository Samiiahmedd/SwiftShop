//
//  SignUpViewModel.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 25/06/1403 AP.
//

import Foundation
import FirebaseAuth
import Combine

@MainActor
protocol SignUpViewModelProtocol {
    var isUserCreated: PassthroughSubject<Bool, Never> { get }
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    func signup(with email: String, password:String) async
}

class SignUpViewModel{
    var isUserCreated: PassthroughSubject<Bool, Never> = .init()
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    init() { }
}

extension SignUpViewModel: SignUpViewModelProtocol {
    func signup(with email: String, password: String) async {
        isLoading.send(true)
        do {
            try await FirebaseManager.shared.signup(with: email, password: password)
            isLoading.send(false)
            isUserCreated.send(true)
        } catch {
            isLoading.send(false)
            errorMessage.send(error.localizedDescription)
        }
    }
}
