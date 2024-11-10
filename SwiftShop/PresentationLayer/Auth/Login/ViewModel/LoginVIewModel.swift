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
    
    private let services: AuthServicesProtocol
    var coordinator: AuthCoordinatorProtocol
    private var cancellable = Set<AnyCancellable>()
    
    var loginTriggered: PassthroughSubject<Void, Never> = .init()
    var forgetPasswordActionTriggered: PassthroughSubject<Void, Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    var email: String = ""
    var password: String = ""
    
    init(services: AuthServicesProtocol = AuthServices(),
         coordinator: AuthCoordinatorProtocol) {
        self.services = services
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
        
        let validator = LoginBody(email: email, password: password)
        let validationResult = validator.validate()
        
        guard validationResult.isValid else {
            isLoading.send(false)
            errorMessage.send(validationResult.errorMessage ?? "Unknown validation error")
            return
        }
        
        isLoading.send(true)
        let body = LoginBody(email: email, password: password)
        services.login(with: body)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                isLoading.send(false)
                switch completion {
                case .finished:
                    print("Go to reviced value")
                case .failure(let error):
                    errorMessage.send(error.localizedDescription)
                }
            } receiveValue: { user in
                AppCoordinator.shared.showTabBar()
            }
            .store(in: &cancellable)
    }
}
