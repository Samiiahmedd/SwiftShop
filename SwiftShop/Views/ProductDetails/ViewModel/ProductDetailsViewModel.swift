//
//  ProductDetailsViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 07/09/2024.
//

import Foundation
class ProductDetailsViewModel {
    
    // NewArrival Product Details
    @MainActor
    func getNewArrivalsProducts(id: Int, completion: @escaping (Result<ProductDetailsModel, Error>) -> Void) {
        guard let url = URL(string: "https://fakestoreapi.com/products/\(id)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? APIError.failedTogetData))
                return
            }
            do {
                let product = try JSONDecoder().decode(ProductDetailsModel.self, from: data)
                completion(.success(product))
            } catch {
                print("Error decoding data: \(error)")
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
}
