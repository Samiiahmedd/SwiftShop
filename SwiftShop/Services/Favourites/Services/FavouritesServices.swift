//
//  FavouritesServices.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 25/11/2024.
//

import Foundation
import Combine
import NetworkLayer

//MARK: - PROTOCOLS

protocol FavouritesServicesProtocol {
    func addProductToFavourites(with body: FavouritesBody) -> AnyPublisher<FavouritesData, NetworkError>
    func getFavourites() -> AnyPublisher<inFavouritesData, NetworkError>
    func deleteFavouriteItem(with body: FavouritesBody) -> AnyPublisher<FavouritesData, NetworkError>
}

struct FavouritesServices: FavouritesServicesProtocol {

    //MARK: - PROPIRITES
    
    private let network = NetworkRequestable()
    
    //MARK: - ADD TO FAVOURITES
    
    func addProductToFavourites(with body: FavouritesBody) -> AnyPublisher<FavouritesData, NetworkError> {
        let endPoint = FavouritesEndPoint.addProductToFavourites
        let requestModel = RequestModel(endPoint: endPoint, reqBody: body)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<FavouritesData>) -> AnyPublisher<FavouritesData, NetworkError> in
                guard baseModel.status == true else {
                    return Fail(error: NetworkError.serverError(code: 199, error: baseModel.message ?? ""))
                        .eraseToAnyPublisher()
                }
                
                if let favourites = baseModel.data {
                    return Just(favourites)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.invalidJSON(error: "Failed to parse CartData"))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: - DELETE
    
    func deleteFavouriteItem(with body: FavouritesBody) -> AnyPublisher<FavouritesData, NetworkLayer.NetworkError> {
        
        let endPoint = FavouritesEndPoint.DeleteFavourites
        let requestModel = RequestModel(endPoint: endPoint, reqBody: body)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<FavouritesData>) -> AnyPublisher<FavouritesData, NetworkError> in
                guard baseModel.status == true else {
                    return Fail(error: NetworkError.serverError(code: 199, error: baseModel.message ?? ""))
                        .eraseToAnyPublisher()
                }
                if let cartData = baseModel.data {
                    return Just(cartData)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.invalidJSON(error: "Failed to parse CartData"))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: - GET FAVOURITES
    
    func getFavourites() -> AnyPublisher<inFavouritesData, NetworkLayer.NetworkError> {
        let endPoint = FavouritesEndPoint.GetFavourites
        let requestModel = RequestModel(endPoint: endPoint)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<inFavouritesData>) -> AnyPublisher<inFavouritesData, NetworkError> in
                guard baseModel.status == true else {
                    return Fail(error: NetworkError.serverError(code: 199, error: baseModel.message!))
                        .eraseToAnyPublisher()
                }
                if let productData = baseModel.data {
                    return Just(productData)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.invalidJSON(error: "Failed to parse products"))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
