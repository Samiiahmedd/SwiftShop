//
//  LoginVIewModel.swift.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 24/06/1403 AP.
//

import Foundation
import Combine

@MainActor
protocol LoginViewModelProtocol {
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    var loginTriggered: PassthroughSubject<Void, Never> { get }
    
    var email: String { get set }
    var password: String { get set }
}

@MainActor
class LoginViewModel {
    
    var coordinator: MainCoordinator
    private var cancellable = Set<AnyCancellable>()

    var loginTriggered: PassthroughSubject<Void, Never> = .init()
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()

    var email: String = ""
    var password: String = ""
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        bindIsLoginTriggered()
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    func bindIsLoginTriggered() {
        loginTriggered
            .sink { [weak self] _ in self?.login() }
            .store(in: &cancellable)
        
    }
}

private extension LoginViewModel {
    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage.send("Please enter valid email and password")
            return
        }
        isLoading.send(true)
        let netowkManager = NetworkManager<User>()
        Task {
            do {
                let body: [String: Any] = ["email": email, "password": password]
                let user = try await netowkManager.postData(to: "/auth/login", body: body)
                print("User data: \(user)")
                isLoading.send(false)
                coordinator.start()
            } catch {
                isLoading.send(false)
                errorMessage.send(error.localizedDescription)
            }
        }
    }
}
