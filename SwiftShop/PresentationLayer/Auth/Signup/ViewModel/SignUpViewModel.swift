//
//  SignUpViewModel.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 25/06/1403 AP.
//

import Foundation
import Combine

@MainActor
protocol SignUpViewModelProtocol {
    
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    /// input
    var isUserCreated: PassthroughSubject<Void, Never> { get }
    var backActionTriggerd: PassthroughSubject<Void, Never>  { get }
    
    ///variables
    var name: String { get set }
    var  email: String { get set }
    var  password: String { get set }
    var  confirmPassword: String { get set }
}

class SignUpViewModel  {
    
    var coordinator: AuthCoordinatorProtocol
    private var cancellable = Set<AnyCancellable>()
    
    var isUserCreated: PassthroughSubject<Void, Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
        bindIsSignupTriggered()
    }}

extension SignUpViewModel: SignUpViewModelProtocol {
    func bindIsSignupTriggered() {
        isUserCreated
            .sink { [weak self] _ in self?.signup() }
            .store(in: &cancellable)
        
        backActionTriggerd
            .sink { [weak self] _ in self?.coordinator.pop() }
            .store(in: &cancellable)
    }
}

private extension SignUpViewModel {
    func signup() {
        guard
            !email.isEmpty, !password.isEmpty, !name.isEmpty, !confirmPassword.isEmpty else {
            errorMessage.send("Please Fill All Fields.")
            return
        }
        guard password == confirmPassword else {
            errorMessage.send("Passwords do not match.")
            return
        }
        isLoading.send(true)
        let networkManager = NetworkManager<User>()
        Task {
            do {
                let body: [String: Any] = [
                    "name": name,
                    "email": email,
                    "password": password,
                    "confirmPassword": confirmPassword
                ]
                _ = try await networkManager.postData(to: "/auth/signup", body: body)
                isLoading.send(false)
                coordinator.popToLogin()
            } catch {
                isLoading.send(false)
                errorMessage.send(error.localizedDescription)
            }
        }
    }
}
