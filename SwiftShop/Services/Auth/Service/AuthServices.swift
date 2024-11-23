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
    func veifyEmail(with credentials: VerifyEmailBody) -> AnyPublisher<UserModel, NetworkError>
    func veifyCode(with credentials: VerifyCodeBody) -> AnyPublisher<UserModel, NetworkError>
    func resetPassword(with credentials: ResetPasswordBody) -> AnyPublisher<UserModel, NetworkError>
}

struct AuthServices: AuthServicesProtocol {
    
    private let network = NetworkRequestable()
    
    func login(with credentials: LoginBody) -> AnyPublisher<UserModel, NetworkError> {
        
        let endPoint = AuthEndPoint.login
        let requestModel = RequestModel(endPoint: endPoint, reqBody: credentials)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<UserModel>) -> AnyPublisher<UserModel, NetworkError> in
                guard baseModel.status == true else {
                    return Fail(error: NetworkError.serverError(code: 199, error: baseModel.message ?? ""))
                        .eraseToAnyPublisher()
                }
                
                if let userData = baseModel.data {
                    return Just(userData)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.invalidJSON(error: "Failed to parse UserModel"))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func signup(with credentials: SignupBody) ->AnyPublisher<UserModel, NetworkError> {
        let endPoint = AuthEndPoint.signup
        let requestModel = RequestModel(endPoint: endPoint, reqBody: credentials)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<UserModel>) -> AnyPublisher<UserModel, NetworkError> in
                guard baseModel.status == true else {
                    return Fail(error: NetworkError.serverError(code: 199, error: baseModel.message ?? ""))
                        .eraseToAnyPublisher()
                }
                
                if let userData = baseModel.data {
                    return Just(userData)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.invalidJSON(error: "Failed to parse UserModel"))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func veifyEmail(with credentials: VerifyEmailBody) -> AnyPublisher<UserModel, NetworkLayer.NetworkError> {
        let endPoint = AuthEndPoint.verfiyEmail
        let requestModel = RequestModel(endPoint: endPoint, reqBody: credentials)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<UserModel>) -> AnyPublisher<UserModel, NetworkError> in
                guard baseModel.status == true else {
                    return Fail(error: NetworkError.serverError(code: 199, error: baseModel.message ?? ""))
                        .eraseToAnyPublisher()
                }
                
                if let userData = baseModel.data {
                    return Just(userData)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.invalidJSON(error: "Failed to parse UserModel"))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func veifyCode(with credentials: VerifyCodeBody) -> AnyPublisher<UserModel, NetworkLayer.NetworkError> {
        let endPoint = AuthEndPoint.verfiyEmail
        let requestModel = RequestModel(endPoint: endPoint, reqBody: credentials)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<UserModel>) -> AnyPublisher<UserModel, NetworkError> in
                guard baseModel.status == true else {
                    return Fail(error: NetworkError.serverError(code: 199, error: baseModel.message ?? ""))
                        .eraseToAnyPublisher()
                }
                
                if let userData = baseModel.data {
                    return Just(userData)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.invalidJSON(error: "Failed to parse UserModel"))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    func resetPassword(with credentials: ResetPasswordBody) -> AnyPublisher<UserModel, NetworkLayer.NetworkError> {
        let endPoint = AuthEndPoint.resetPassword
        let requestModel = RequestModel(endPoint: endPoint, reqBody: credentials)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<UserModel>) -> AnyPublisher<UserModel, NetworkError> in
                guard baseModel.status == true else {
                    return Fail(error: NetworkError.serverError(code: 199, error: baseModel.message ?? ""))
                        .eraseToAnyPublisher()
                }
                
                if let userData = baseModel.data {
                    return Just(userData)
                        .setFailureType(to: NetworkError.self)
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: NetworkError.invalidJSON(error: "Failed to parse UserModel"))
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
