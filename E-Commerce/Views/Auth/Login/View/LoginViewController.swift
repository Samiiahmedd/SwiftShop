//
//  LoginViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 19/07/2024.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
    //MARK: -IBOUtlet
    
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var emailTxtFiedl: UITextField!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var passwordTxtField: UITextField!
    @IBOutlet var fbLogin: UIButton!
    @IBOutlet var appleLogin: UIButton!
    @IBOutlet var googleLogin: UIButton!
    
    //MARK: -Variables
    
    private var viewModel: LoginViewModelProtocol = LoginViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: -ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    //MARK: -IBActions
    
    @IBAction func loginBtn(_ sender: Any) {
        makeLoginRequest()
    }
    
    @IBAction func fbLogin(_ sender: Any) {
        // Implement Facebook login logic here
    }
    
    @IBAction func appleLogin(_ sender: Any) {
        // Implement Apple login logic here
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        // Implement Google login logic here
    }
}

// MARK: - SETUP VIEW

private extension LoginViewController {
    func setupView() {
        handelEndEditing()
        configureTextFields()
    }
    
    func configureTextFields() {
        let textFields: [UITextField] = [emailTxtFiedl, passwordTxtField]
        textFields.forEach { $0.delegate = self }
    }
}

// MARK: - VIEW MODEL

private extension LoginViewController {
    func bindViewModel() {
        bindIsLoading()
        bindErrorState()
        bindIsLogin()
    }
    
    func bindIsLoading() {
        viewModel.isLoading.sink { [weak self] isLoading in
            guard let self else { return }
            if isLoading {
                loaderView.isHidden = false
                loaderView.startAnimating()
            } else {
                loaderView.stopAnimating()
            }
        }.store(in: &cancellable)
    }
    
    func bindErrorState() {
        viewModel.errorMessage.sink { [weak self] error in
            guard let self else { return }
            showErrorAlert(message: error)
        }.store(in: &cancellable)
    }
    
    func bindIsLogin() {
        viewModel.isLogin.sink { [weak self] isLogin in
            guard let self else { return }
            navigateToHomeVC()
        }.store(in: &cancellable)
    }
    
    func makeLoginRequest() {
        Task {
            guard let email = emailTxtFiedl.text, !email.isEmpty,
                  let password = passwordTxtField.text, !password.isEmpty else { return }
            await viewModel.login(with: email, password: password)
        }
    }
}

// MARK: - TEXT FIELD DELEGATE

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTxtFiedl:
            passwordTxtField.becomeFirstResponder()
        default:
            makeLoginRequest()
            view.endEditing(true)
        }
        return true
    }
}