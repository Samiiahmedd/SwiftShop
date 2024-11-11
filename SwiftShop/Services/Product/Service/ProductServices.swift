//
//  ProductServices.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 07/11/2024.
//

import Foundation
import Combine
import NetworkLayer


protocol ProductServicesProtocol {
    func getHomeProducts() -> AnyPublisher<HomeData, NetworkError>
}

struct ProductServices: ProductServicesProtocol {
    
    private let network = NetworkRequestable()
    
    func getHomeProducts() -> AnyPublisher<HomeData, NetworkLayer.NetworkError> {
        
        let endPoint = ProductEndPoint.homeProducts
        let requestModel = RequestModel(endPoint: endPoint)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<HomeData>) -> AnyPublisher<HomeData, NetworkError> in
                guard baseModel.status == true else {
                    return Fail(error: NetworkError.serverError(code: 199, error: baseModel.message))
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








