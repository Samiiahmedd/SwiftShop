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
    func login(with credentials: LoginBody) -> AnyPublisher<UserModel, NetworkError>
    func signup(with credentials: SignupBody) -> AnyPublisher<UserModel, NetworkError>
    
}

struct AuthServices: AuthServicesProtocol {
    
    private let network = NetworkRequestable()
    
    func login(with credentials: LoginBody) -> AnyPublisher<UserModel, NetworkError> {
        let endPoint = AuthEndPoint.login
        let requestModel = RequestModel(endPoint: endPoint, reqBody: credentials)
        return network.request(requestModel)
                    .flatMap { (baseModel: BaseModel<UserModel>) -> AnyPublisher<UserModel, NetworkError> in
                        
                        guard baseModel.status == true else {
                            return Fail(error: NetworkError.serverError(code: 192, error: baseModel.message))
                                .eraseToAnyPublisher()
                        }

                        return Just(baseModel.data)
                            .setFailureType(to: NetworkError.self)
                            .eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()

    }
    
    func signup(with credentials: SignupBody) ->AnyPublisher<UserModel, NetworkError> {
        let endPoint = AuthEndPoint.signup
        let requestModel = RequestModel(endPoint: endPoint, reqBody: credentials)
        
        return network.request(requestModel)
                    .flatMap { (baseModel: BaseModel<UserModel>) -> AnyPublisher<UserModel, NetworkError> in
                        
                        guard baseModel.status == true else {
                            return Fail(error: NetworkError.serverError(code: 192, error: baseModel.message))
                                .eraseToAnyPublisher()
                        }

                        return Just(baseModel.data)
                            .setFailureType(to: NetworkError.self)
                            .eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
    }
    
}
