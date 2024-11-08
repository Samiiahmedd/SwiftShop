//
//  OTPViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 01/10/2024.
//

import Foundation
import Combine

@MainActor
protocol OTPViewModelProtocol {
    var isVerified: PassthroughSubject<Bool, Never> { get }
    var isLoading: PassthroughSubject<Bool, Never> { get }
    var errorMessage: PassthroughSubject<String, Never> { get }
    
    func verifyOTP(with resetCode: String, email :String) async
}

class OTPViewModel: OTPViewModelProtocol {
    var isVerified: PassthroughSubject<Bool, Never> = .init()
    var isLoading: PassthroughSubject<Bool, Never> = .init()
    var errorMessage: PassthroughSubject<String, Never> = .init()
    
    func verifyOTP(with resetCode: String, email: String) async {
        isLoading.send(true)
        guard let url = URL(string: "\(Constants.baseURL)/auth/verifyOTP") else {
            isLoading.send(false)
            errorMessage.send("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["resetCode": resetCode, "email": email] 

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            isLoading.send(false)
            errorMessage.send("Failed to encode OTP data.")
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
                        isVerified.send(true)
                        print("Code sent successfully: \(result)")
                        errorMessage.send(result.message)
                    } catch {
                        errorMessage.send("Failed to parse response.")
                    }
                case 400:
                    errorMessage.send("Bad Request: Invalid OTP.")
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
