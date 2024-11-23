//
//  ShippinAddressViewModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 23/11/2024.
//

import Foundation
import Combine

@MainActor
protocol AddShippingAddressViewModelProtocol {
    
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    /// input
    var addButtonTriggered: PassthroughSubject<Void, Never> { get }
    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
    
    ///  variables
    var name: String { get set }
    var city: String { get set }
    var region: String { get set }
    var details: String { get set }
    var notes: String { get set }
    
}

@MainActor
class AddShippingAddressViewModel {
    
    private let services: Address_ServiceProtocol
    var coordinator: HomeCoordinatorProtocol
    private var cancellable = Set<AnyCancellable>()
    
    var addButtonTriggered: PassthroughSubject<Void, Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    var name: String = ""
    var city: String = ""
    var region: String = ""
    var details: String = ""
    var notes: String = ""
    
    init(services: Address_ServiceProtocol = Address_Service(),
         coordinator: HomeCoordinatorProtocol) {
        self.services = services
        self.coordinator = coordinator
        bindIsAddButtonTriggered()
    }
}

extension AddShippingAddressViewModel: AddShippingAddressViewModelProtocol {
    func bindIsAddButtonTriggered() {
        addButtonTriggered
            .sink { [weak self] _ in self?.addAddress() }
            .store(in: &cancellable)
        
        
        backActionTriggerd
            .sink { [weak self] _ in self?.coordinator.pop() }
            .store(in: &cancellable)
    }
}

private extension AddShippingAddressViewModel {
    
    func addAddress() {
        
        let validator = AddressBody(name: name, city: city, region: region, details: details, latitude: 12, longitude: 12, notes: notes)
        let validationResult = validator.validate()
        
        guard validationResult.isValid else {
            isLoading.send(false)
            errorMessage.send(validationResult.errorMessage ?? "Unknown  error")
            return
        }
        
        isLoading.send(true)
        let body = AddressBody(name: name, city: city, region: region, details: details, latitude: 12, longitude: 12, notes: notes)
        services.addAddress(with: body)
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
                coordinator.displayAllAdrese()
            }
            .store(in: &cancellable)
    }
}
