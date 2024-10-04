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
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var emailTxtFiedl: UITextField!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var passwordTxtField: UITextField!
    @IBOutlet weak var forgetPasswordButton: UIButton!
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the default navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationItem.hidesBackButton = true
    }
    
    //MARK: -IBActions
    
    @IBAction func loginBtn(_ sender: Any) {
        makeLoginRequest()
    }
    
    @IBAction func forgetPasswordButton(_ sender: Any) {
        let forgetPass = ForgetPasswordViewController(nibName: "ForgetPasswordViewController", bundle: nil)
        self.navigationController?.pushViewController(forgetPass, animated: true)
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func fbLogin(_ sender: Any) {
        // Facebook login
    }
    
    @IBAction func appleLogin(_ sender: Any) {
        // Apple login
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        //  Google login
    }
}

// MARK: - SETUP VIEW

private extension LoginViewController {
    func setupView() {
        handelEndEditing()
        configureTextFields()
        configureNavBar()
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
    
    func configureTextFields() {
        let textFields: [UITextField] = [emailTxtFiedl, passwordTxtField]
        textFields.forEach { $0.delegate = self }
        addPasswordToggleButton()
    }
    
    func addPasswordToggleButton() {
         let passwordToggleBtn = UIButton(type: .custom)
        passwordToggleBtn.setImage (UIImage(systemName: "eye"), for: .normal)
         passwordToggleBtn.setImage(UIImage(systemName: "eye.slash"), for: .selected)
         passwordToggleBtn.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        passwordToggleBtn.tintColor = .black
         passwordTxtField.rightView = passwordToggleBtn
         passwordTxtField.rightViewMode = .always
     }
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
          sender.isSelected.toggle()
          
          passwordTxtField.isSecureTextEntry.toggle()
          
          if let existingText = passwordTxtField.text, passwordTxtField.isSecureTextEntry {
              passwordTxtField.deleteBackward()
              passwordTxtField.insertText(existingText)
          }
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
                self.showLoader()
            } else {
                self.hideLoader()
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
                  let password = passwordTxtField.text, !password.isEmpty else {return}
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
