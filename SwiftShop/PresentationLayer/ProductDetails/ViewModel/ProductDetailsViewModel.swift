//
//  ProductDetailsViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 07/09/2024.
//

import Foundation
import UIKit
import Combine

@MainActor
protocol ProductDetailsViewModelProtocol {
    
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    var showProducts : PassthroughSubject<String,Never> { get }
    
    /// input
    
    var addToCartButtonActionTriggered: PassthroughSubject<Void, Never> { get }
    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
    
}

@MainActor
class ProductDetailsViewModel {
    private let services: ProductServicesProtocol
    private var cancellable = Set<AnyCancellable>()
    
    var sizes : [SizeModel] = [
        .init(size: "S"),
        .init(size: "M"),
        .init(size: "L"),
        .init(size: "XL"),
        .init(size: "XXL")
    ]
    var colors: [UIColor] = [.red, .black, .lightGray, .green, .orange]
     var id: Int
    
    var productDetailsDataSource: [ProductDetails] = []
    var ProductDetails = PassthroughSubject<ProductDetails, Never>()
    
    var coordinator:HomeCoordinatorProtocol?
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    var showProducts : PassthroughSubject<String,Never> = .init()
    var addToCartButtonActionTriggered: PassthroughSubject<Void, Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    
    init(id: Int, services: ProductServicesProtocol = ProductServices(), coordinator: HomeCoordinatorProtocol) {
        self.id = id
        self.services = services
        self.coordinator = coordinator
    }
}

extension ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    
    func bindIsProductDetailsHome() {
        backActionTriggerd
            .sink { [weak self] _ in self?.coordinator!.pop() }
            .store(in: &cancellable)
    }
}

extension ProductDetailsViewModel {
    func getProductDetails() {
        isLoading.send(true)
        services.getProductDetails(id: id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading.send(false)
                switch completion {
                case .finished:
                    print("Finished fetching product details")
                case .failure(let error):
                    self.errorMessage.send(error.localizedDescription)
                }
            } receiveValue: { [weak self] productDetails in
                print("Received product details data")
                self?.ProductDetails.send(productDetails)
            }
            .store(in: &cancellable)
    }
    
}
