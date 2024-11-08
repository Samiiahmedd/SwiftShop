//
//  SearchCategoriesViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/09/2024.
//

import Foundation
import UIKit

class SearchCategoriesViewModel {
    
    func getCategoriesList() async throws -> [String] {
        guard let url = URL(string: "https://fakestoreapi.com/products/categories") else {
            throw RequestError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw RequestError.noData
        }
        
        // Decode the response directly into an array of strings
        let categories = try JSONDecoder().decode([String].self, from: data)
        return categories
    }
    
}
