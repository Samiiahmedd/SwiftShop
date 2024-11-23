//
//  ShippingAddressViewModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 23/11/2024.
//

import Foundation
import Combine

@MainActor
protocol ShippingAddressViewModelProtocol {
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    /// input
    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
}

@MainActor
class ShippingAddressViewModel: ShippingAddressViewModelProtocol {
    var addressData = PassthroughSubject<Data, Never>()
    var address: [AddressData] = []
    private var selectedAddress: AddressData?
    private let services: Address_ServiceProtocol
    var coordinator: HomeCoordinatorProtocol
    private var cancellable = Set<AnyCancellable>()
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    
    init(services: Address_ServiceProtocol = Address_Service(),
         coordinator: HomeCoordinatorProtocol) {
        self.services = services
        self.coordinator = coordinator
    }
    
    func getAddress() {
        isLoading.send(true)
        services.getAddress()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading.send(false)
                if case .failure(let error) = completion {
                    self?.errorMessage.send(error.localizedDescription)
                }
            } receiveValue: { [weak self] address in
                self?.addressData.send(address)
            }
            .store(in: &cancellable)
    }
    
    
    func selectAddress(_ address: AddressData) {
        self.selectedAddress = address
    }
    
    func getSelectedAddress() -> AddressData? {
        return selectedAddress
    }
}


