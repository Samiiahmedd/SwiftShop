//
//  OTPViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 01/10/2024.
//

import Foundation
import Combine

@MainActor
protocol OTPViewModelProtocol {
    
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    /// input
    var verifyCodeButtonTriggerd: PassthroughSubject<Void, Never> { get }
    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
    
    ///  variables
    var email: String { get set }
    var code: String { get set }
  
}

@MainActor
class OTPViewModel {
    
    private let services: AuthServicesProtocol
    var coordinator: AuthCoordinatorProtocol
    private var cancellable = Set<AnyCancellable>()
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    var verifyCodeButtonTriggerd: PassthroughSubject<Void, Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    
    var email: String = ""
    var code: String = ""
    
    
    init(services: AuthServicesProtocol = AuthServices(),
         coordinator: AuthCoordinatorProtocol) {
        self.services = services
        self.coordinator = coordinator
        verifyOTPButtonTriggered()
    }
    
}
    
extension OTPViewModel: OTPViewModelProtocol {
    
    func verifyOTPButtonTriggered() {
        
        verifyCodeButtonTriggerd
            .sink { [weak self] _ in self?.verifyOTP() }
            .store(in: &cancellable)
        
        backActionTriggerd
            .sink { [weak self] _ in self?.coordinator.pop() }
            .store(in: &cancellable)
    }
    
    func verifyOTP()  {
        isLoading.send(true)
        let body = VerifyCodeBody(email: email, code: code)
        services.veifyCode(with: body)
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
            } receiveValue: { [self] user in
                self.coordinator.displayNewPassword(with: email, Code: code)
            }
            .store(in: &cancellable)
    }
}
        
        
        
        
        
        
        
