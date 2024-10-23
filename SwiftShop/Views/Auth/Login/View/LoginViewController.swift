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
    
    var coordinator: AuthCoordinatorProtocol?
    private var viewModel: LoginViewModelProtocol
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: -ViewLifeCycle
    
    init() {
        let coordinator = MainCoordinator(window: UIApplication.shared.windows.first!)
        viewModel = LoginViewModel(coordinator: coordinator)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
        configureKeyboardHandling()
    }
    deinit {
        removeKeyboardHandling()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func loginBtn(_ sender: Any) {
        makeLoginRequest()
    }
    
    @IBAction func forgetPasswordButton(_ sender: Any) {
        coordinator?.displayForgetPassword()
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
        loginUser()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "",
                                       and: UIImage(named: "back")!) { [weak self] in
            guard let self else { return }
            coordinator?.pop()
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
    
    func loginUser() {
        // After successful login
        UserDefaults.isLogin = true
        (coordinator as? AppCoordinator)?.goToHomeFlow()
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
    
    func makeLoginRequest() {
        viewModel.email = emailTxtFiedl.text ?? ""
        viewModel.password = passwordTxtField.text ?? ""
        viewModel.loginTriggered.send()
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
