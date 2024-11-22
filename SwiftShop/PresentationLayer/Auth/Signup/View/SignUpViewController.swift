//
//  SignUpViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 03/08/2024.
//

import UIKit
import Combine

class SignUpViewController: UIViewController {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var nameTxtField: UITextField!
    @IBOutlet var emailTxtField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var passwordTxtField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var checkMarkButton: UIButton!
    
    //MARK: - VARIBALES
    var coordinator: AuthCoordinatorProtocol?
    private var viewModel: SignUpViewModelProtocol
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - VIEW LIFE CYCLE
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
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
    
    //MARK: -IBACTIONS
    
    @IBAction func signupButton(_ sender: Any) {
        makeSignupRequest()
    }
    
    @IBAction func checkMarkButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        let imageName = sender.isSelected ? "checkmark.circle.fill" : "checkmark.circle"
            checkMarkButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

// MARK: - SETUP VIEW

private extension SignUpViewController {
    func setupView() {
        handelEndEditing()
        configureTextFields()
        configureNavBar()
        configureCheckMark()
    }
            
    func configureTextFields() {
        let textFields: [UITextField] = [nameTxtField,phoneNumberTextField, emailTxtField,passwordTxtField ]
        textFields.forEach { $0.delegate = self }
        addPasswordToggleButtons()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "",
                                       and: UIImage(named: "back")!) { [weak self] in
            guard let self else { return }
            coordinator?.pop()
        }
        navBar.firstTralingButton.isHidden = true
        navBar.lastFirstTralingButton.isHidden = true
    }
    
    func addPasswordToggleButtons() {
        let passwordToggleBtn = UIButton(type: .custom)
        passwordToggleBtn.setImage(UIImage(systemName: "eye"), for: .normal)
        passwordToggleBtn.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        passwordToggleBtn.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
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

    
    func configureCheckMark() {
        checkMarkButton.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
    }
}

// MARK: - VIEW MODEL

private extension SignUpViewController {
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
            AlertViewController.showAlert(on: self, image:UIImage(systemName: "xmark.circle.fill")!, title: "Signup Failed", message: error, buttonTitle: "OK") {
            }
        }.store(in: &cancellable)
    }
    
    func makeSignupRequest() {
        viewModel.name = nameTxtField.text ?? ""
        viewModel.email = emailTxtField.text ?? ""
        viewModel.password = passwordTxtField.text ?? ""
        viewModel.phone = phoneNumberTextField.text ?? ""
        viewModel.isUserCreated.send()
        }
    }

// MARK: - TEXT FIELD DELEGATE

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTxtField:
            phoneNumberTextField.becomeFirstResponder()
        case phoneNumberTextField:
            emailTxtField.becomeFirstResponder()
        case emailTxtField:
            passwordTxtField.becomeFirstResponder()
        default:
            makeSignupRequest()
            view.endEditing(true)
        }
        return true
    }
}


