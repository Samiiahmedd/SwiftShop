//
//  ForgetPasswordViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 30/09/2024.
//

import UIKit
import Combine

class ForgetPasswordViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: - VARIABLES
    var coordinator: AuthCoordinatorProtocol?
    private var viewModel: ForgetPasswordViewModelProtocol = ForgetPasswordViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func nextButtonAction(_ sender: Any) {
        makeResetRequest()
    }
}


// MARK: - SETUP VIEW

private extension ForgetPasswordViewController {
    func setupView() {
        configureNavBar()
        bindViewModel()
        configureTextFields()
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
        addPaddingToTextField(emailTextField, padding: 10)
    }
}

// MARK: - VIEW MODEL

private extension ForgetPasswordViewController {
    func bindViewModel() {
        bindIsLoading()
        bindErrorState()
        bindIsReset()
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
    
    func bindIsReset() {
        viewModel.isReset
            .sink { [weak self] isReset in
                guard let self = self else { return }
                coordinator?.displayVerifyOtp(with: self.emailTextField.text ?? "")
            }
            .store(in: &cancellable)
    }
    
    func makeResetRequest() {
        Task {
            guard let email = emailTextField.text, !email.isEmpty else {return}
            await viewModel.forgetPassword(with: email)
        }
    }
    
}
