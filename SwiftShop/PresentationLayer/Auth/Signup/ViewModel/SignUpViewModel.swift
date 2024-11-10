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
    var phone: String { get set }
    var  email: String { get set }
    var  password: String { get set }
}

@MainActor
class SignUpViewModel  {
    
    private let services: AuthServicesProtocol
    var coordinator: AuthCoordinatorProtocol
    private var cancellable = Set<AnyCancellable>()
    
    var isUserCreated: PassthroughSubject<Void, Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    var name: String = ""
    var phone: String = ""
    var email: String = ""
    var password: String = ""
    
    init(services: AuthServicesProtocol = AuthServices(),
         coordinator: AuthCoordinatorProtocol) {
        self.services = services
        self.coordinator = coordinator
        bindIsSignupTriggered()
    }
}

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
        isLoading.send(true)
        
        let body = SignupBody(name: name, phone: phone, email: email, password: password)
        guard body.isValid() else {
            isLoading.send(false)
            errorMessage.send("All fields are required!")
            return
        }
        
        services.signup(with: body)
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
                self.coordinator.popToLogin()
            }
            .store(in: &cancellable)
    }
}
