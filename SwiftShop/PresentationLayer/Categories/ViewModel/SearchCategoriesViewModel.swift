//
//  SearchCategoriesViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/09/2024.
//

import Foundation
import UIKit
import Combine

@MainActor
protocol SearchCategoriesViewModelProtocol {
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    var showCategories : PassthroughSubject<String,Never> { get }
    
    /// input
    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
    var categoryCellTriggered: PassthroughSubject<Void, Never> { get }
    
}


@MainActor
class SearchCategoriesViewModel {
    
    var categoryDataSource: [Category] = []
    var mainCategoryDataSource: [CategoryData] = []
    
    var categories = PassthroughSubject<CategoryData, Never>()

    private let services: CategoriesServicesProtocol
    private var cancellable = Set<AnyCancellable>()
    var coordinator:HomeCoordinatorProtocol
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    var showCategories : PassthroughSubject<String,Never> = .init()
    
    var categoryCellTriggered: PassthroughSubject<Void, Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    
    init(services: CategoriesServicesProtocol = CategoriesServices(),
         coordinator: HomeCoordinatorProtocol) {
        self.services = services
        self.coordinator = coordinator
    }
}

extension SearchCategoriesViewModel: SearchCategoriesViewModelProtocol {
    func bindIsCategoriesList() {
        backActionTriggerd
            .sink { [weak self] _ in self?.coordinator.pop() }
            .store(in: &cancellable)
        
        //        categoryCellTriggered
        //            .sink { [weak self] _ in self?.coordinator.displayProductDetailsScreen() }
        //            .store(in: &cancellable)
    }
}

    extension SearchCategoriesViewModel {

        func getAllCategories() {
            isLoading.send(true)
            services.getAllCategories()
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
                } receiveValue: { [weak self] categories in
                    self?.categoryDataSource = categories.data
                    self?.categories.send(categories)
                }
                .store(in: &cancellable)
        }
        
        
    }

    
    
    
    
