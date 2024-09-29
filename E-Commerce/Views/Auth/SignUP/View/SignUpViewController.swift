//
//  SignUpViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 03/08/2024.
//

import UIKit
import Combine

class SignUpViewController: UIViewController {
    
    //MARK: -IBOUtlet
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var nameTxtField: UITextField!
    @IBOutlet var emailTxtField: UITextField!
    @IBOutlet var confirmPasswordTxtField: UITextField!
    @IBOutlet var passwordTxtField: UITextField!
    
    
    //MARK: - VARIBALES
    
    private var viewModel: SignUpViewModelProtocol = SignUpViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: -ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: -IBActions
    
    @IBAction func loginBtb(_ sender: Any) {
        makeSignupRequest()
    }
}

// MARK: - SETUP VIEW

private extension SignUpViewController {
    func setupView() {
        handelEndEditing()
        configureTextFields()
        configureNavBar()
    }
            
    func configureTextFields() {
        let textFields: [UITextField] = [nameTxtField, emailTxtField,passwordTxtField,confirmPasswordTxtField ]
        textFields.forEach { $0.delegate = self }
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "",
                                       and: UIImage(named: "back")!) {
            let start = StartScreenViewController(nibName: "StartScreenViewController", bundle: nil)
            self.navigationController?.pushViewController(start, animated: true)
            self.navigationItem.hidesBackButton = true
        }
        navBar.firstTralingButton.isHidden = true
    }
}

// MARK: - VIEW MODEL

private extension SignUpViewController {
    func bindViewModel() {
        bindIsLoading()
        bindErrorState()
        bindIsUserCreated()
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
    
    func bindIsUserCreated() {
        viewModel.isUserCreated.sink { [weak self] isLogin in
            guard let self else { return }
            navigateToHomeVC()
        }.store(in: &cancellable)
    }
    
    func makeSignupRequest() {
        Task {
            guard let name = nameTxtField.text, !name.isEmpty,
                  let email = emailTxtField.text, !email.isEmpty,
                  let password = passwordTxtField.text, !password.isEmpty,
                  let confirmPassword = confirmPasswordTxtField.text, !confirmPassword.isEmpty,
                  password == confirmPassword else { return }
            await viewModel.signup(with: email, password: password)
        }
    }
}



// MARK: - TEXT FIELD DELEGATE

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTxtField:
            emailTxtField.becomeFirstResponder()
        case emailTxtField:
            passwordTxtField.becomeFirstResponder()
        case passwordTxtField:
            confirmPasswordTxtField.becomeFirstResponder()
        default:
            makeSignupRequest()
            view.endEditing(true)
        }
        return true
    }
}


