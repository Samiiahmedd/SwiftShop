//
//  AuthErrorHandler.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 09/11/2024.
//

import Foundation

class AuthErrorHandler {
    
    // Function to handle validation errors (422)
    static func handleValidationErrors(_ data: Data) -> String {
        do {
            let errorResponse = try JSONDecoder().decode(ServerErrorResponse.self, from: data)
            var formattedErrorMessage = ""
            for error in errorResponse.errors {
                formattedErrorMessage += "\n• \(error.msg)"
            }
            return formattedErrorMessage
        } catch {
            print("Error decoding validation error: \(error.localizedDescription)")
            return "Failed to parse validation errors."
        }
    }

    
    // Function to handle server errors (500, etc.)
    static func handleServerError(statusCode: Int) -> String {
        switch statusCode {
        case 400:
            return "Invalid email or password."
        case 500:
            return "Server is currently unavailable. Please try again later."
        default:
            return "An unexpected error occurred. Status code: \(statusCode)"
        }
    }
    
    // Function to handle unexpected errors
    static func handleUnexpectedError(_ error: Error) -> String {
        return "An unexpected error occurred: \(error.localizedDescription)"
    }
}
