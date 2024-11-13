//
//  ProductServices.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 07/11/2024.
//

import Foundation
import Combine
import NetworkLayer

//MARK: - PROTOCOLS

protocol ProductServicesProtocol {
    func getHomeProducts() -> AnyPublisher<HomeData, NetworkError>
    func getProductDetails(id:Int) -> AnyPublisher<ProductDetails, NetworkError>
    
}

struct ProductServices: ProductServicesProtocol {
    
    //MARK: - VARIABLES
    
    private let network = NetworkRequestable()
    
    //MARK: - Get Home Products
    
    func getHomeProducts() -> AnyPublisher<HomeData, NetworkLayer.NetworkError> {
        
        let endPoint = ProductEndPoint.homeProducts
        let requestModel = RequestModel(endPoint: endPoint)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<HomeData>) -> AnyPublisher<HomeData, NetworkError> in
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
    
    //MARK: - Get Product Details
    
    func getProductDetails(id:Int) -> AnyPublisher<ProductDetails, NetworkLayer.NetworkError> {
        let endPoint = ProductEndPoint.productDetails(id: id)
        let requestModel = RequestModel(endPoint: endPoint)
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<ProductDetails>) -> AnyPublisher<ProductDetails, NetworkError> in
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








