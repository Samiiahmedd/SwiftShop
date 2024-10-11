//
//  ShippingAddressViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 11/10/2024.
//

import UIKit

// MARK: - AddressDelegate Protocol

protocol AddressDelegate: AnyObject {
    func didAddAddress(_ address: Address)
}

class ShippingAddressViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNuberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var addAdressButton: UIButton!
    
    //MARK: - VARIABLES
    
    weak var delegate: AddressDelegate?

    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func addAdressButtonAction(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty,
               let phone = phoneNuberTextField.text, !phone.isEmpty,
               let address = addressTextField.text, !address.isEmpty else {
            showErrorAlert(message: "Fill All Fields")
             return
         }
         let newAddress = Address(name: name, phone: phone, address: address)
         delegate?.didAddAddress(newAddress)
         navigationController?.popViewController(animated: true)
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
    }
    
    func configureTextFields() {
        addPaddingToTextField(nameTextField, padding: 10)
        addPaddingToTextField(phoneNuberTextField, padding: 10)
        addPaddingToTextField(addressTextField, padding: 10)
        
        let textFields: [UITextField] = [nameTextField, phoneNuberTextField,addressTextField ]
        textFields.forEach { $0.delegate = self }
        
    }
}

// MARK: - TEXT FIELD DELEGATE

extension ShippingAddressViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField:
            phoneNuberTextField.becomeFirstResponder()
        case phoneNuberTextField:
            addressTextField.becomeFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
}


