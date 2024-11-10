//
//  AuthCoordinator.swift
//  SwiftShop
//
//  Created by Abdalazem Saleh on 06/10/2024.
//

import UIKit

protocol AuthCoordinatorProtocol: Coordinator {
    func displayOnBoarding()
    func displayStartScreen()
    func displayLogin()
    func displaySignup()
    func displayForgetPassword()
    func displayVerifyOtp(with email: String)
    func displayNewPassword(with email: String, Code:String)
    func displaySuccessScreen()
    func displayTabBar()
    func popToLogin()
}

final class AuthCoordinator {
    
    var router: any Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        displayStartScreen()
    }
}

extension AuthCoordinator: AuthCoordinatorProtocol {
    
    func displayStartScreen() {
        DispatchQueue.main.async {
            let vc = StartScreenViewController()
            vc.coordinator = self
            self.router.push(vc)
        }
    }
    
    func displayOnBoarding() {
        
    }
    
    func displayLogin() {
        DispatchQueue.main.async {
            let viewModel = LoginViewModel(coordinator: self)
            let vc = LoginViewController(viewModel: viewModel)
            self.router.push(vc)
        }
    }
    
    func displaySignup() {
        DispatchQueue.main.async {
            let viewModel = SignUpViewModel(coordinator: self)
            let vc = SignUpViewController(viewModel: viewModel)
            vc.coordinator = self
            self.router.push(vc)
        }
    }
    
    func displayForgetPassword() {
        DispatchQueue.main.async {
            let viewModel = ForgetPasswordViewModel(coordinator: self)
            let vc = ForgetPasswordViewController(viewModel: viewModel)
            vc.coordinator = self
            self.router.push(vc)
        }
    }
    
    func displayVerifyOtp(with email: String) {
        DispatchQueue.main.async {
            let viewModel = OTPViewModel(coordinator: self)
            let vc = OTPViewController(viewModel: viewModel)
            vc.coordinator = self
            self.router.push(vc)
        }
    }
    
    func displayNewPassword(with email: String, Code:String) {
        DispatchQueue.main.async {
            let viewModel = UpdatePasswordViewModel(coordinator: self)
            let vc = UpdatePasswordViewController(viewModel: viewModel)
            vc.coordinator = self
        ///*here!!!! and all inject !!!!!
//            vc.viewModel.email = email
            self.router.push(vc)
        }
    }
    
    func displaySuccessScreen() {
        DispatchQueue.main.async {
            let vc = ResetPasswordSuccessViewController()
            vc.coordinator = self
            self.router.push(vc)
        }
    }
    
    func displayTabBar() {
        DispatchQueue.main.async {
            AppCoordinator.shared.showTabBar()
        }
    }

    func popToLogin() {
        DispatchQueue.main.async {
            if let targetViewController = self.router.navigationController.viewControllers.first(where: { $0 is LoginViewController }) {
                self.router.popToViewController(targetViewController)
            }
        }
    }
}
