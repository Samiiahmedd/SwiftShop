//
//  LoginVIewModel.swift.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 24/06/1403 AP.
//

import Foundation
import Combine

@MainActor
protocol LoginViewModelProtocol {
    var isLogin: PassthroughSubject<Bool, Never> { get }
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    func login(with email: String, password: String) async
}

class LoginViewModel {
    var responseHandler: ((_ result: Result<User, Error>) -> Void)?
    var isLogin: PassthroughSubject<Bool, Never> = .init()
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    init() { }
}

extension LoginViewModel: LoginViewModelProtocol {
    
    func login(with email: String, password: String) async {
        
        isLoading.send(true)
        guard let url = URL(string: "\(Constants.baseURL)/auth/login") else {
            isLoading.send(false)
            errorMessage.send("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["email": email, "password": password]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            isLoading.send(false)
            errorMessage.send("Failed to encode login data.")
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                isLoading.send(false)
                
                switch httpResponse.statusCode {
                case 200:
                    // Successful login
                    let user = try JSONDecoder().decode(User.self, from: data)
                    isLogin.send(true)
                    print(user)
                    
                case 400:
                    // Bad Request
                    errorMessage.send("Invalid email or password.")
                    
                case 401:
                    // Unauthorized
                    errorMessage.send("Unauthorized access. Please check your credentials.")
                    
                case 403:
                    // Forbidden
                    errorMessage.send("You do not have permission to access this resource.")
                    
                case 404:
                    // Not Found
                    errorMessage.send("Endpoint not found.")
                    
                case 500:
                    // Internal Server Error
                    errorMessage.send("Server is currently unavailable. Please try again later.")
                    
                default:
                    // Handle other status codes as necessary
                    errorMessage.send("An unexpected error occurred. Status code: \(httpResponse.statusCode)")
                }
            } else {
                isLoading.send(false)
                errorMessage.send("Failed to receive a valid response from the server.")
            }
            
        } catch {
            isLoading.send(false)
            errorMessage.send(error.localizedDescription)
        }
    }
}
