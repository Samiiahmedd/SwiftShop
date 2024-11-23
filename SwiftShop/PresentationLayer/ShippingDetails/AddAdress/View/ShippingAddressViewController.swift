//
//  ShippingAddressViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 11/10/2024.
//

import UIKit
import Combine


class ShippingAddressViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var addAdressButton: UIButton!
    
    //MARK: - VARIABLES
    
    private var viewModel: AddShippingAddressViewModel
    private var cancellable = Set<AnyCancellable>()
    var coordinator: HomeCoordinatorProtocol?
    
    //MARK: - INITIALIZER
    
    init(viewModel: AddShippingAddressViewModel) {
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
    
    @IBAction func addAdressButtonAction(_ sender: Any) {
        makeAddRequest()
    }
}

//MARK: - SETUP VIEW

extension ShippingAddressViewController {
    func setupView() {
        configureNavBar()
        configureTextFields()
        handelEndEditing()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) {
            self.navigationController?.popViewController(animated: true)
        }
        navBar.firstTralingButton.isHidden = true
        navBar.lastFirstTralingButton.isHidden = true
    }
    
    func configureTextFields() {
        addPaddingToTextField(nameTextField, padding: 10)
        addPaddingToTextField(cityTextField, padding: 10)
        addPaddingToTextField(regionTextField, padding: 10)
        addPaddingToTextField(detailsTextField, padding: 10)
        addPaddingToTextField(notesTextField, padding: 10)
        
        let textFields: [UITextField] = [nameTextField, cityTextField,regionTextField,detailsTextField,notesTextField ]
        textFields.forEach { $0.delegate = self }
        
    }
}

// MARK: - TEXT FIELD DELEGATE

extension ShippingAddressViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            cityTextField.becomeFirstResponder()
        case cityTextField:
            cityTextField.becomeFirstResponder()
        case cityTextField:
            regionTextField.becomeFirstResponder()
        case regionTextField:
            detailsTextField.becomeFirstResponder()
        case detailsTextField:
            notesTextField.becomeFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
}

// MARK: - VIEW MODEL

private extension ShippingAddressViewController {
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
            AlertViewController.showAlert(on: self, image:UIImage(systemName: "xmark.circle.fill")!, title: "Login Error", message: error, buttonTitle: "OK") {
            }
        }.store(in: &cancellable)
    }
    
    func makeAddRequest() {
        viewModel.name = nameTextField.text ?? ""
        viewModel.city = cityTextField.text ?? ""
        viewModel.region = regionTextField.text ?? ""
        viewModel.details = detailsTextField.text ?? ""
        viewModel.notes = notesTextField.text ?? ""
        viewModel.addButtonTriggered.send()
    }
}

