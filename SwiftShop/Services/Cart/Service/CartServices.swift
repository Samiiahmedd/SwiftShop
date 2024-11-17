//
//  CartServices.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 17/11/2024.
//

import Foundation
import Combine
import NetworkLayer

protocol CartServicesProtocol {
    func addProductToCart(with body: CartBody) -> AnyPublisher<CartData, NetworkError>
}

struct CartServices: CartServicesProtocol {
    
    private let network = NetworkRequestable()
    
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
}
