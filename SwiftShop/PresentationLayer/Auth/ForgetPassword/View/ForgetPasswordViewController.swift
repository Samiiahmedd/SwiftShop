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
    
    private var viewModel: ForgetPasswordViewModel
    private var cancellable = Set<AnyCancellable>()
    var coordinator: AuthCoordinatorProtocol?
    
    //MARK: - INITIALIZER
    
    init(viewModel: ForgetPasswordViewModel) {
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
            viewModel.backActionTriggerd.send()
        }
        navBar.firstTralingButton.isHidden = true
        navBar.lastFirstTralingButton.isHidden = true
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
            AlertViewController.showAlert(on: self, image:UIImage(systemName: "xmark.circle.fill")!, title: "Error", message: error, buttonTitle: "OK") {
            }
        }.store(in: &cancellable)
    }
    
    
    func makeResetRequest() {
        viewModel.email =  emailTextField.text ?? ""
        viewModel.nextButtonTriggerd.send()
    }
    
}
