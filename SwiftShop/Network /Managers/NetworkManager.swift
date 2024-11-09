//
//  NetworkManager.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 05/10/2024.
//

import Foundation
import UIKit

import Foundation

class NetworkManager<T: Codable> {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData(from path: String) async throws -> T {
        let urlString = Constants.baseURL + path
        guard let url = URL(string: urlString) else {
            throw RequestError.invalidURL
        }
        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else { throw RequestError.unexpectedStatusCode }
        
        switch httpResponse.statusCode {
        case 200:
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw RequestError.decode
            }
        case 422:
            let errorMessage = AuthErrorHandler.handleValidationErrors(data)
            throw NSError(domain: "", code: 422, userInfo: [NSLocalizedDescriptionKey: errorMessage])
        case 500:
            let errorMessage = AuthErrorHandler.handleServerError(statusCode: httpResponse.statusCode)
            throw NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: errorMessage])
        default:
            throw RequestError.unexpectedStatusCode
        }
    }
    
        func postData(to path: String, body: [String: Any]) async throws -> T {
            
            let urlString = Constants.baseURL + path
            guard let url = URL(string: urlString) else {
                throw RequestError.invalidURL
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw RequestError.unexpectedStatusCode
            }
            
            switch httpResponse.statusCode {
            case 200:
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return decodedData
                } catch {
                    throw RequestError.decode
                }
            case 422:
                let errorMessage = AuthErrorHandler.handleValidationErrors(data)
                throw NSError(domain: "", code: 422, userInfo: [NSLocalizedDescriptionKey: errorMessage])
            case 500:
                let errorMessage = AuthErrorHandler.handleServerError(statusCode: httpResponse.statusCode)
                throw NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: errorMessage])
            default:
                throw RequestError.unexpectedStatusCode
            }
        }
    }
