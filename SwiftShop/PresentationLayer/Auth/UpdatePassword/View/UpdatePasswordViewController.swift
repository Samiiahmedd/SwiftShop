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
    @IBOutlet weak var updatePasswordButton: UIButton!
    
    //MARK: - Variables
    
    var coordinator: AuthCoordinatorProtocol?
    private var viewModel : UpdatePasswordViewModel
    private var cancellable = Set<AnyCancellable>()

    //MARK: - INITIALIZER
    
    init(viewModel: UpdatePasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()

    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func updatePasswordButtonActiion(_ sender: Any) {
        bindIsUpdated()
    }
}


//MARK: - SETUP VIEW

private extension UpdatePasswordViewController {
    func setupView() {
        configureNavBar()
        configureTextFields()
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
    }
        
}

extension UpdatePasswordViewController {
   
   func bindViewModel() {
           bindIsLoading()
           bindErrorState()
       }
       
       func bindIsLoading() {
           viewModel.isLoading.sink { [weak self] isLoading in
               guard let self = self else { return }
               if isLoading {
                   self.showLoader()
               } else {
                   self.hideLoader()
               }
           }.store(in: &cancellable)
       }
       
       func bindErrorState() {
           viewModel.errorMessage.sink { [weak self] error in
               guard let self = self else { return }
               showErrorAlert(message: error)
           }.store(in: &cancellable)
       }
       
    func bindIsUpdated() {
        viewModel.updateButtonTriggered.send()

    }
   }
