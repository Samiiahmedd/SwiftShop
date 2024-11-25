//
//  WishlistViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 02/10/2024.
//

import Foundation
import UIKit
import Combine

@MainActor
protocol WishlistViewModelProtocol {
    /// output
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
}


class WishlistViewModel {
    
    // MARK: - Properties
    
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    var id: Int
    private var cancellable = Set<AnyCancellable>()
    var coordinator:HomeCoordinatorProtocol
    private let services: FavouritesServicesProtocol
    var favouritesItem : [inFavouritesItem] = []
    var inFavouritesData = PassthroughSubject<inFavouritesData, Never>()
    
    // MARK: - Initialization
    
    init(id: Int,services: FavouritesServicesProtocol = FavouritesServices(),
         coordinator: HomeCoordinatorProtocol) {
        self.id = id
        self.services = services
        self.coordinator = coordinator
    }
}

extension WishlistViewModel {
    //GET
    
    func getFavourites() {
        isLoading.send(true)
        services.getFavourites()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading.send(false)
            } receiveValue: { [weak self] products in
                print(products)
                self?.inFavouritesData.send(products)
            }
            .store(in: &cancellable)
    }
    
    //DELETE
    
    func deleteProductFromFavourites(productId: Int) {
        let body = FavouritesBody(product_id: productId)
        isLoading.send(true)
        services.deleteFavouriteItem(with: body)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading.send(false)
                switch completion {
                case .finished:
                    print("Product deleted added to the cart.")
                case .failure(let error):
                    self.errorMessage.send(error.localizedDescription)
                }
            } receiveValue: { cartData in
                print("ProductDeleted")
            }
            .store(in: &self.cancellable)
    }
}
