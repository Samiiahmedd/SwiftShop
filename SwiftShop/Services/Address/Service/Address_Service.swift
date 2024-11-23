//
//  Address_Service.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 23/11/2024.
//

import Foundation
import Combine
import NetworkLayer

protocol Address_ServiceProtocol {
    func addAddress(with body: AddressBody) -> AnyPublisher<AddressData,NetworkError>
    func getAddress() -> AnyPublisher<Data,NetworkError>
}

struct Address_Service: Address_ServiceProtocol {
    
    private let network = NetworkRequestable()
    
    func addAddress(with body: AddressBody) -> AnyPublisher<AddressData, NetworkLayer.NetworkError> {
        let endPoint = AddressEndPoint.addAddress
        let requestModel = RequestModel(endPoint: endPoint, reqBody: body)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<AddressData>) -> AnyPublisher<AddressData, NetworkError> in
                guard baseModel.status == true else {
                    return Fail(error: NetworkError.serverError(code: 199, error: baseModel.message ?? ""))
                        .eraseToAnyPublisher()
                }
                
                if let userData = baseModel.data {
                    return Just(userData)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.invalidJSON(error: "Failed to add address"))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func getAddress() -> AnyPublisher<Data, NetworkLayer.NetworkError> {
        
        let endPoint = AddressEndPoint.getAddress
        let requestModel = RequestModel(endPoint: endPoint)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<Data>) -> AnyPublisher<Data, NetworkError> in
                guard baseModel.status == true else {
                    return Fail(error: NetworkError.serverError(code: 199, error: baseModel.message ?? ""))
                        .eraseToAnyPublisher()
                }
                
                if let userData = baseModel.data {
                    return Just(userData)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.invalidJSON(error: "Failed to add address"))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}

