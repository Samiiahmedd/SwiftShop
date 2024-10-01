//
//  UpdatePasswordViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 01/10/2024.
//

import Foundation
import Combine

@MainActor
protocol UpdatePasswordViewModelProtocol {
    var isUpdated: PassthroughSubject<Bool, Never> { get }
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    func updatePassword(with email: String, newPassword:String) async
}

class UpdatePasswordViewModel {
    
    var responseHandler: ((_ result: Result<UpdatePasswordResponse, Error>) -> Void)?
    
    var isUpdated: PassthroughSubject<Bool, Never> = .init()
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    init() { }
}

extension UpdatePasswordViewModel: UpdatePasswordViewModelProtocol {
    func updatePassword(with email: String, newPassword: String) async {
        isLoading.send(true)
        guard let url = URL(string: "\(Constants.baseURL)/auth/resetPassword") else {
            isLoading.send(false)
            errorMessage.send("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": email, "newPassword": newPassword]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            isLoading.send(false)
            errorMessage.send("Failed to encode password data.")
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(ResetPasswordResponse.self, from: data)
                        isUpdated.send(true) 
                        print("Password reset successfully: \(result)")
                        errorMessage.send(result.message)
                    } catch {
                        errorMessage.send("Failed to parse response.")
                    }
                case 400:
                    errorMessage.send("Bad Request: Invalid email or password.")
                case 500...599:
                    errorMessage.send("Server error. Please try again later.")
                default:
                    errorMessage.send("Unexpected error. Status code: \(httpResponse.statusCode)")
                }
            }
        } catch {
            errorMessage.send("Request failed: \(error.localizedDescription)")
        }
        
        isLoading.send(false)
    }
    
}


