//
//  HomeViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 04/09/2024.
//

import Foundation
import UIKit
import Combine

@MainActor
protocol HomeViewModelProtocol {
    
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    var showBanners : PassthroughSubject<String,Never> { get }
    var showProducts : PassthroughSubject<String,Never> { get }
    
    /// input
    var viewAllButtonActionTriggered: PassthroughSubject<Void, Never> { get }
    var productCellTriggered: PassthroughSubject<Void, Never> { get }
    var searchButtonActionTriggered: PassthroughSubject<Void, Never> { get }
    var categoriesButtonActionTriggered: PassthroughSubject<Void, Never> { get }
    var backActionTriggerd: PassthroughSubject<Void, Never> { get }
    
}

@MainActor
class HomeViewModel {
    var productsDataSource: [Product] = []
    var productsDataaSource: [HomeData] = []
    var bannersDataSource: [Banner] = []
    var adImageURL: String?
    
    var homeData = PassthroughSubject<HomeData, Never>()
    private let services: ProductServicesProtocol
    private var cancellable = Set<AnyCancellable>()
    var coordinator:HomeCoordinatorProtocol
    
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    var showBanners : PassthroughSubject<String,Never> = .init()
    var showProducts : PassthroughSubject<String,Never> = .init()
    
    var productCellTriggered: PassthroughSubject<Void, Never> = .init()
    var viewAllButtonActionTriggered: PassthroughSubject<Void, Never> = .init()
    var searchButtonActionTriggered: PassthroughSubject<Void, Never> = .init()
    var categoriesButtonActionTriggered: PassthroughSubject<Void, Never> = .init()
    var backActionTriggerd: PassthroughSubject<Void, Never> = .init()
    
    init(services: ProductServicesProtocol = ProductServices(),
         coordinator: HomeCoordinatorProtocol) {
        self.services = services
        self.coordinator = coordinator
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func bindIsHome() {
        
        productCellTriggered
            .sink { [weak self] _ in self?.coordinator.displayProductDetailsScreen() }
            .store(in: &cancellable)
        
        backActionTriggerd
            .sink { [weak self] _ in self?.coordinator.pop() }
            .store(in: &cancellable)
        
        viewAllButtonActionTriggered
            .sink { [weak self] _ in self?.coordinator.displayAllProducts() }
            .store(in: &cancellable)
        
        searchButtonActionTriggered
            .sink { [weak self] _ in self?.coordinator.displaySearchScreen() }
            .store(in: &cancellable)
        
        categoriesButtonActionTriggered
            .sink { [weak self] _ in self?.coordinator.displayCategoriesScreen() }
            .store(in: &cancellable)
    }
}

extension HomeViewModel {
    
    func getHomeProducts() {
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
                print("ViewModel received data with \(homeData.banners.count) banners and \(homeData.products.count) products")
                self?.bannersDataSource = homeData.banners
                self?.productsDataSource = homeData.products
                self?.adImageURL = homeData.ad
                self?.homeData.send(homeData)
            }
            .store(in: &cancellable)
    }
}
