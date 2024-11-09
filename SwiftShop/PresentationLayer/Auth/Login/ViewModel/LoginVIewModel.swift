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
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    /// input
    var loginTriggered: PassthroughSubject<Void, Never> { get }
    var forgetPasswordActionTriggered: PassthroughSubject<Void, Never> { get }
    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
    
    ///  variables
    var email: String { get set }
    var password: String { get set }
}

@MainActor
class LoginViewModel {
    
    var coordinator: AuthCoordinatorProtocol
    private var cancellable = Set<AnyCancellable>()
    
    var loginTriggered: PassthroughSubject<Void, Never> = .init()
    var forgetPasswordActionTriggered: PassthroughSubject<Void, Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    var email: String = ""
    var password: String = ""
    
    init(coordinator: AuthCoordinatorProtocol) {
        self.coordinator = coordinator
        bindIsLoginTriggered()
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    func bindIsLoginTriggered() {
        loginTriggered
            .sink { [weak self] _ in self?.login() }
            .store(in: &cancellable)
        
        forgetPasswordActionTriggered
            .sink { [weak self] _ in self?.coordinator.displayForgetPassword() }
            .store(in: &cancellable)
        
        backActionTriggerd
            .sink { [weak self] _ in self?.coordinator.pop() }
            .store(in: &cancellable)
    }
}

private extension LoginViewModel {
    
    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage.send("Please provide both email and password.")
            return
        }
        isLoading.send(true)
        let networkManager = NetworkManager<User>()
        Task {
            do {
                let body: [String: Any] = ["email": email, "password": password]
                let user = try await networkManager.postData(to: "/auth/login", body: body)
                isLoading.send(false)
                AppCoordinator.shared.showTabBar()
            } catch {
                isLoading.send(false)
                errorMessage.send(error.localizedDescription)
            }
        }
    }
}
