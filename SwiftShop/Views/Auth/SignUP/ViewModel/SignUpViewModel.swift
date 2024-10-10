//
//  SignUpViewModel.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 25/06/1403 AP.
//

import Foundation
import Combine

@MainActor
protocol SignUpViewModelProtocol {
    var isUserCreated: PassthroughSubject<Bool, Never> { get }
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    func signup(with name: String, email: String, password:String, confirmPassword: String ) async
}

class SignUpViewModel{
    var isUserCreated: PassthroughSubject<Bool, Never> = .init()
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    init() { }
}

extension SignUpViewModel: SignUpViewModelProtocol {
    func signup(with name: String, email: String, password: String, confirmPassword: String) async {
        
        isLoading.send(true)
        guard let url = URL(string: "\(Constants.baseURL)/auth/signup") else {
            isLoading.send(false)
            errorMessage.send("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["name" : name,"email": email, "password": password, "confirmPassword" : confirmPassword]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            isLoading.send(false)
            errorMessage.send("Failed to encode signUp data.")
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                isLoading.send(false)
                
                switch httpResponse.statusCode {
                case 201:
                    // Successful SignUp
                    let user = try JSONDecoder().decode(User.self, from: data)
                    isUserCreated.send(true)
                    print("User signed up successfully: \(user)")
                    
                case 400:
                    // Bad Request
                    errorMessage.send("Invalid email or password.")
                    
                case 409:
                    // Conflict: User already exists
                    errorMessage.send("A user with this email already exists.")
                    
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

