//
//  SearchCategoriesViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/09/2024.
//

import Foundation
import UIKit

class SearchCategoriesViewModel{
    
    @MainActor
    func getCategoriesList(completion:@escaping (Result <CategoriesResponse, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/cats") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(CategoriesResponse.self, from: data)
                print(data)
                completion(.success(results))
            }catch{
                print("Error")
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
}

