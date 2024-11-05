//
//  CartViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/09/2024.
//

import Foundation

class CartViewModel {
    func fetchCartFromAPI(completion: @escaping (Result<[CartResponse], Error>) -> Void) {
        guard let url = URL(string: "https://fakestoreapi.com/carts") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                // Handle no data case
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let cartData = try JSONDecoder().decode([CartResponse].self, from: data)
                completion(.success(cartData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

}

