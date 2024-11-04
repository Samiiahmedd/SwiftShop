//
//  NetworkManager.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 05/10/2024.
//

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
        case 400:
            throw RequestError.notAllowed
        case 401:
            throw RequestError.notAllowed
        case 403:
            throw RequestError.forbidden
        case 404:
            throw RequestError.notFounded
        case 500:
            throw RequestError.serverError
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
                let jsonString = String(data: data, encoding: .utf8) ?? "No data"
                print("Received JSON data: \(jsonString)")
                
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                print("Decoding error: \(error)")
                throw RequestError.decode
            }        case 400:
            throw RequestError.notAllowed
        case 401:
            throw RequestError.notAllowed
        case 403:
            throw RequestError.forbidden
        case 404:
            throw RequestError.notFounded
        case 500:
            throw RequestError.serverError
        default:
            throw RequestError.unexpectedStatusCode
        }
    }
}
