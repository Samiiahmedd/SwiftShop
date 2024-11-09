//
//  AuthServices.swift
//  SwiftShop
//
//  Created by Abdalazem Saleh on 09/11/2024.
//

import Foundation
import Combine
import NetworkLayer

protocol AuthServicesProtocol {
    func login(with credentials: LoginBody) -> AnyPublisher<BaseModel<UserModel>, NetworkError>
}

struct AuthServices: AuthServicesProtocol {
    
    private let network = NetworkRequestable()
    
    func login(with credentials: LoginBody) -> AnyPublisher<BaseModel<UserModel>, NetworkError> {
        let endPoint = AuthEndPoint.login
        let requestModel = RequestModel(endPoint: endPoint, reqBody: credentials)
        
        return network.request(requestModel)
    }
}
