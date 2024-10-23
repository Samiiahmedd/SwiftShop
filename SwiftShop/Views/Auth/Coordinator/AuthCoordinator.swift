//
//  AuthCoordinator.swift
//  SwiftShop
//
//  Created by Abdalazem Saleh on 06/10/2024.
//

import UIKit

@MainActor
protocol AuthCoordinatorProtocol {
    func displayLogin()
    func displaySignup()
    func displayForgetPassword()
    func displayVerifyOtp(with email: String)
    func displayNewPassword(with email: String)
    func displaySuccessScreen()
    func popToLogin()
    func pop()
    func dismiss()
}

final class AuthCoordinator {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = StartScreenViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}

extension AuthCoordinator: AuthCoordinatorProtocol {
    
    func displayLogin() {
        let vc = LoginViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func onLoginSuccess() {
            // Save user login status
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            UserDefaults.standard.synchronize()
            
            // Switch to home flow
            (UIApplication.shared.delegate as? AppDelegate)?.appCoordinator?.goToHomeFlow()
        }

    
    func displaySignup() {
        let vc = SignUpViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func displayForgetPassword() {
        let vc = ForgetPasswordViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func displayVerifyOtp(with email: String) {
        let vc = OTPViewController()
        vc.coordinator = self
        vc.email = email
        navigationController.pushViewController(vc, animated: true)
    }
    
    func displayNewPassword(with email: String) {
        let vc = UpdatePasswordViewController()
        vc.coordinator = self
        vc.email = email
        navigationController.pushViewController(vc, animated: true)
    }
    
    func displaySuccessScreen() {
        let vc = ResetPasswordSuccessViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func popToLogin() {
        if let targetViewController = navigationController.viewControllers.first(where: { $0 is LoginViewController }) {
            navigationController.popToViewController(targetViewController, animated: true)
        }
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
