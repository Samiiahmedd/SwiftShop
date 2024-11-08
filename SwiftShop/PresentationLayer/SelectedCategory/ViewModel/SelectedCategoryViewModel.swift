//
//  SelectedCategoryViewModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 04/11/2024.
//

import Foundation


class SelectedCategoryViewModel {
    func getProductsByCategory(_ category: String) async throws -> [NewArrival] {
        let urlString = "https://fakestoreapi.com/products/category/\(category)"
        guard let url = URL(string: urlString) else {
            throw RequestError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw RequestError.noData
        }
        let products = try JSONDecoder().decode([NewArrival].self, from: data)
        return products
    }


}

