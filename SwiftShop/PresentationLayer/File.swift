//
//  File.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 06/10/2024.
//


private extension LoginViewModel {
    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage.send("Please enter valid email and password")
            return
        }
        isLoading.send(true)
        let netowkManager = NetworkManager<User>()
        Task {
            do {
                let body: [String: Any] = ["email": email, "password": password]
                let user = try await netowkManager.postData(to: "/auth/login", body: body)
                isLoading.send(false)
                print("User is \(user)")
            } catch {
                isLoading.send(false)
                errorMessage.send(error.localizedDescription)
            }
        }
    }
}
