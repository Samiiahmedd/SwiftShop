//
//  SelectedCategoryViewModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 04/11/2024.
//

import Foundation
import Combine

@MainActor
protocol SelectedCategoryViewModelProtocol {
    
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    var showProducts : PassthroughSubject<String,Never> { get }
    
    /// input
    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
    var productCellTriggerd: PassthroughSubject<Void, Never> { get }
    
    
}

@MainActor
class SelectedCategoryViewModel {
    var productDataSource: [CategoryProduct] = []
    var mainCategoryProductDataSource: [CategoryProductData] = []

    var  id: Int

    var category = PassthroughSubject<CategoryProductData, Never>()
    private let services: CategoriesServicesProtocol
    private var cancellable = Set<AnyCancellable>()
    var coordinator:HomeCoordinatorProtocol
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    var showProducts : PassthroughSubject<String,Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    var productCellTriggerd: PassthroughSubject<Void, Never> = .init()
    
    init(id: Int, services: CategoriesServicesProtocol = CategoriesServices(), coordinator: HomeCoordinatorProtocol) {
        self.id = id
        self.services = services
        self.coordinator = coordinator
    }
}

extension SelectedCategoryViewModel: SelectedCategoryViewModelProtocol {
    
    func bindIsCategoryProducts() {
        backActionTriggerd
            .sink { [weak self] _ in self?.coordinator.pop() }
            .store(in: &cancellable)
        productCellTriggerd
            .sink { [weak self] _ in self?.coordinator.displayProductDetailsScreen(productId: 0) }
            .store(in: &cancellable)
    }
}

extension SelectedCategoryViewModel {
    func getCategory() {
        isLoading.send(true)
        services.getCategory(id: id)
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
            } receiveValue: { [weak self] category in
                self?.productDataSource = category.data
                self?.category.send(category)
            }
            .store(in: &cancellable)
    }
}
