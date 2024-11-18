//
//  CartServices.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 17/11/2024.
//

import Foundation
import Combine
import NetworkLayer

//MARK: - PROTOCOLS

protocol CartServicesProtocol {
    func addProductToCart(with body: CartBody) -> AnyPublisher<CartData, NetworkError>
    func getCart() -> AnyPublisher<inCartData, NetworkError>
    func deleteCartItem(with body: CartBody) -> AnyPublisher<CartData, NetworkError>
    
}

struct CartServices: CartServicesProtocol {
    
    //MARK: - VARIABLES
    
    private let network = NetworkRequestable()
    
    //MARK: - ADD TO CART
    
    func addProductToCart(with body: CartBody) -> AnyPublisher<CartData, NetworkError> {
        let endPoint = CartEndPoint.addProduct
        let requestModel = RequestModel(endPoint: endPoint, reqBody: body)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<CartData>) -> AnyPublisher<CartData, NetworkError> in
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
    
    //MARK: - Delete
    
    func deleteCartItem(with body: CartBody) -> AnyPublisher<CartData, NetworkError> {
        
        let endPoint = CartEndPoint.deleteCartItem
        let requestModel = RequestModel(endPoint: endPoint, reqBody: body)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<CartData>) -> AnyPublisher<CartData, NetworkError> in
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
    
    //MARK: - GET CART
    
    func getCart() -> AnyPublisher<inCartData, NetworkLayer.NetworkError> {
        let endPoint = CartEndPoint.getCart
        let requestModel = RequestModel(endPoint: endPoint)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<inCartData>) -> AnyPublisher<inCartData, NetworkError> in
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
