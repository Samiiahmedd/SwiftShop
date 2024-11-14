//
//  CategoriesServices.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 13/11/2024.
//

import Foundation
import NetworkLayer
import Combine

//MARK: - PROTOCOLS

protocol CategoriesServicesProtocol {
    func getAllCategories() -> AnyPublisher<CategoryData, NetworkError>
    func getCategory(id:Int) -> AnyPublisher<CategoryProductData, NetworkError>
}

struct CategoriesServices: CategoriesServicesProtocol {

    

    //MARK: - VARIABLES
    
    private let network = NetworkRequestable()
    
    //MARK: - GET CATEGORIES
    
    func getAllCategories() -> AnyPublisher<CategoryData, NetworkLayer.NetworkError> {
        
        let endPoint = CategoriesEndPoint.getAllCategories
        let requestModel = RequestModel(endPoint: endPoint)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<CategoryData>) -> AnyPublisher<CategoryData, NetworkError> in
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
    
    func getCategory(id:Int) -> AnyPublisher<CategoryProductData, NetworkLayer.NetworkError> {
        
        let endPoint = CategoriesEndPoint.getCategoryDetails(id: id)
        let requestModel = RequestModel(endPoint: endPoint)
        
        return network.request(requestModel)
            .flatMap { (baseModel: BaseModel<CategoryProductData>) -> AnyPublisher<CategoryProductData, NetworkError> in
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


