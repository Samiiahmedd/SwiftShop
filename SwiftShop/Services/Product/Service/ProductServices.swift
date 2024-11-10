////
////  ProductServices.swift
////  SwiftShop
////
////  Created by Sami Ahmed on 07/11/2024.
////
//
//import Foundation
//import NetworkLayer
//import Combine
//
//
//protocol ProductServicesProtocol {
//    func getProducts(with params: [URLQueryItem]) -> AnyPublisher<[ProductModel], NetworkError>
//}
//
//class ProductServices: ProductServicesProtocol {
//    
//    private let network = NetworkRequestable()
//    
//    func getProducts(with params: [URLQueryItem]) -> AnyPublisher<[ProductModel], NetworkLayer.NetworkError> {
//        let endPoint = ProductEndPoint.products(params)
//        let requestModel = RequestModel(endPoint: endPoint)
//        network.request(requestModel)
//    }
//}
//
//    
//
//
//
//
//
//
