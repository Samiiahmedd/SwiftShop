//
//  UpdatePasswordViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 01/10/2024.
//

import UIKit
import Combine


class UpdatePasswordViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var updatePasswordButton: UIButton!
    
    //MARK: Variables
    var coordinator: AuthCoordinatorProtocol?
    var email : String
    private var viewModel: UpdatePasswordViewModelProtocol = UpdatePasswordViewModel()
    private var cancellable = Set<AnyCancellable>()

    //MARK: - VIEW LIFE CYCLE
    
    init(email: String) {
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func updatePasswordButtonActiion(_ sender: Any) {
        guard let newPassword = newPasswordTextField.text, !newPassword.isEmpty
        else {
            showErrorAlert(message: "Please enter a new password.")
            return
        }
        Task {
            await viewModel.updatePassword(with: email, newPassword: newPassword)
        }
    }
}


//MARK: - SETUP VIEW

private extension UpdatePasswordViewController {
    func setupView() {
        configureNavBar()
        configureTextFields()
        bindViewModel()
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
    
    func configureTextFields() {
     addPaddingToTextField(newPasswordTextField, padding: 10)
     addPaddingToTextField(confirmPasswordTextField, padding: 10)
    }
        
}

extension UpdatePasswordViewController {
   
   func bindViewModel() {
           bindIsLoading()
           bindErrorState()
           bindIsUpdated()
       }
       
       func bindIsLoading() {
           viewModel.isLoading.sink { [weak self] isLoading in
               guard let self = self else { return }
               if isLoading {
                   self.showLoader()  // Show loader
               } else {
                   self.hideLoader()  // Hide loader
               }
           }.store(in: &cancellable)
       }
       
       func bindErrorState() {
           viewModel.errorMessage.sink { [weak self] error in
               guard let self = self else { return }
               showErrorAlert(message: error)  // Show error message
           }.store(in: &cancellable)
       }
       
    func bindIsUpdated() {
        viewModel.isUpdated.sink { [weak self] isUpdated in
            guard let self = self else { return }
            self.coordinator?.displaySuccessScreen()
        }.store(in: &cancellable)
    }
   }