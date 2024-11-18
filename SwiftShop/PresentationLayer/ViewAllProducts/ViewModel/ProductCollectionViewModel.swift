//
//  ProductCollectionViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 06/09/2024.
//

import Foundation
import UIKit
import Combine

@MainActor
protocol ProductCollectionViewModelProtocol {
    
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    var showProducts : PassthroughSubject<String,Never> { get }
    
    /// input
    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
    
}

@MainActor
class ProductCollectionViewModel{
    
    // MARK: - Properties
    
    var productsDataSource: [Product] = []
    var homeData = PassthroughSubject<HomeData, Never>()
    private let services: ProductServicesProtocol
    private var cancellable = Set<AnyCancellable>()
    var coordinator:HomeCoordinatorProtocol
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    var showProducts : PassthroughSubject<String,Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    
    
    init(services: ProductServicesProtocol = ProductServices(),
         coordinator: HomeCoordinatorProtocol) {
        self.services = services
        self.coordinator = coordinator
    }
}

extension ProductCollectionViewModel: ProductCollectionViewModelProtocol {
    
    func bindIsAllProducts() {
        backActionTriggerd
            .sink { [weak self] _ in self?.coordinator.pop() }
            .store(in: &cancellable)
    }
}

extension ProductCollectionViewModel {
    
    func getAllProducts() {
        isLoading.send(true)
        services.getHomeProducts()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading.send(false)
                switch completion {
                case .finished:
                    print("Finished fetching products")
                case .failure(let error):
                    self.errorMessage.send(error.localizedDescription)
                }
            } receiveValue: { [weak self] homeData in
                self?.productsDataSource = homeData.products
                self?.homeData.send(homeData)
            }
            .store(in: &cancellable)
    }
}
