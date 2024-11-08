//
//  ProductCollectionViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 06/09/2024.
//

import Foundation
import UIKit

class ProductCollectionViewModel{
    
    //get all Products
    @MainActor
    func getAllProducts(completion:@escaping (Result <[NewArrival], Error>) -> Void) {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let products = try JSONDecoder().decode([NewArrival].self, from: data)
                
                completion(.success(products))
            }catch{
                print("Error")
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
}
