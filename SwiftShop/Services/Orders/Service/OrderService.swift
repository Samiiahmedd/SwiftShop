//
//  OrdersService.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 23/11/2024.
//

import Foundation
import Combine
import NetworkLayer

protocol OrderServiceProtocol {
    func placeOrder(with body: OrderBody) -> AnyPublisher<OrderResponse, NetworkError>
}

struct OrderService: OrderServiceProtocol {
    
    private let network = NetworkRequestable()
    
    func placeOrder(with body: OrderBody) -> AnyPublisher<OrderResponse, NetworkError> {
        let endPoint = OrderEndPoint.placeOrder
        let requestModel = RequestModel(endPoint: endPoint, reqBody: body)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<OrderResponse>) -> AnyPublisher<OrderResponse, NetworkError> in
                guard baseModel.status == true else {
                    return Fail(error: NetworkError.serverError(code: 199, error: baseModel.message ?? ""))
                        .eraseToAnyPublisher()
                }
                
                if let orderResponse = baseModel.data {
                    return Just(orderResponse)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.invalidJSON(error: "Failed to place order"))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
