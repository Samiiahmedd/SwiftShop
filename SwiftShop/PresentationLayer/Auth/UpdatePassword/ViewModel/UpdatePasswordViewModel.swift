//
//  UpdatePasswordViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 01/10/2024.
//

import Foundation
import Combine

@MainActor
protocol UpdatePasswordViewModelProtocol {
    
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    /// input
    var updateButtonTriggered: PassthroughSubject<Void, Never> { get }
    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
    
    ///  variables
    var email: String { get set }
    var code: String { get set }
    var password: String { get set }
    
}

@MainActor
class UpdatePasswordViewModel {
    
    private let services: AuthServicesProtocol
    var coordinator: AuthCoordinatorProtocol
    private var cancellable = Set<AnyCancellable>()
    
    var updateButtonTriggered: PassthroughSubject<Void, Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    var email: String = ""
    var code: String = ""
    var password: String = ""
    
    init(services: AuthServicesProtocol = AuthServices(),
         coordinator: AuthCoordinatorProtocol) {
        self.services = services
        self.coordinator = coordinator
        //        bindIsLoginTriggered()
    }
}

extension UpdatePasswordViewModel: UpdatePasswordViewModelProtocol {
    func bindIsUpdatedTriggered() {
        
        updateButtonTriggered
            .sink { [weak self] _ in self?.updatePassword() }
            .store(in: &cancellable)
        
        backActionTriggerd
            .sink { [weak self] _ in self?.coordinator.pop() }
            .store(in: &cancellable)
        
    }
}

private extension UpdatePasswordViewModel {
    
    func updatePassword() {
        isLoading.send(true)
        let body = ResetPasswordBody(email: email, code: code, password: password)
        services.resetPassword(with: body)
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
                self.coordinator.displaySuccessScreen()
            }
            .store(in: &cancellable)
    }
}
