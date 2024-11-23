//
//  CardEnterViewModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 23/11/2024.
//

import Foundation
import Combine

@MainActor
protocol CardEnterViewModelProtocol {
    
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    /// input
    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
}

@MainActor
class CardEnterViewModel {
    
    //MARK: - PROPIRITES
    
    private let services: OrderServiceProtocol
    var coordinator: HomeCoordinatorProtocol
    private var cancellable = Set<AnyCancellable>()
    
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    //MARK: - INITIALIZER
    
    init(services: OrderServiceProtocol = OrderService(),
         coordinator: HomeCoordinatorProtocol) {
        self.services = services
        self.coordinator = coordinator
        bindIsAddButtonTriggered()
    }
}
extension CardEnterViewModel: CardEnterViewModelProtocol {
    func bindIsAddButtonTriggered() {
        backActionTriggerd
            .sink { [weak self] _ in self?.coordinator.pop() }
            .store(in: &cancellable)
    }
}

 extension CardEnterViewModel {
    
    func placeOrder() {
        isLoading.send(true)
        let body = OrderBody(address_id: 4695, payment_method: 1, use_points: false, promo_code_id: 0)
        services.placeOrder(with: body)
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
                print("Done")
            }
            .store(in: &cancellable)
    }
}
