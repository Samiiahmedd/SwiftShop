//
//  ForgetPasswordViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 01/10/2024.
//

import Foundation
import Combine

@MainActor
protocol ForgetPasswordViewModelProtocol {
    
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    /// input
    var nextButtonTriggerd: PassthroughSubject<Void, Never> { get }
    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
    
    
    ///  variables
    var email: String { get set }
}

@MainActor
class ForgetPasswordViewModel {
    
    private let services: AuthServicesProtocol
    var coordinator: AuthCoordinatorProtocol
    private var cancellable = Set<AnyCancellable>()
    
    
    var nextButtonTriggerd: PassthroughSubject<Void, Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    var email: String = ""
    
    init(services: AuthServicesProtocol = AuthServices(),
         coordinator: AuthCoordinatorProtocol) {
        self.services = services
        self.coordinator = coordinator
        bindNextButtonTriggered()
    }
}

extension ForgetPasswordViewModel: ForgetPasswordViewModelProtocol {
    func bindNextButtonTriggered() {
        
        nextButtonTriggerd
            .sink { [weak self] _ in self?.forgetPassword() }
            .store(in: &cancellable)
        
        backActionTriggerd
            .sink { [weak self] _ in self?.coordinator.pop() }
            .store(in: &cancellable)
    }
}

private extension ForgetPasswordViewModel {
    
    func forgetPassword() {
        let validator = VerifyEmailBody(email: email)
        guard validator.isValid() else {
            isLoading.send(false)
            errorMessage.send("Please enter a valid email address.")
            return
        }
        isLoading.send(true)

        let body = VerifyEmailBody(email: email)
        services.veifyEmail(with: body)
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
                self.coordinator.displayVerifyOtp(with: self.email)
            }
            .store(in: &cancellable)
    }
}
