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
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
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
              let city = cityTextField.text, !city.isEmpty,
              let address = addressTextField.text, !address.isEmpty,
              let zip = zipcodeTextField.text, !zip.isEmpty else {
            showErrorAlert(message: "Please Fill All Fields!")
            return
        }
        let newAddress = Address(name: name, phone: phone,city: city, address: address,zipCode: zip)
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
        navBar.lastFirstTralingButton.isHidden = true
    }
    
    func configureTextFields() {
        addPaddingToTextField(nameTextField, padding: 10)
        addPaddingToTextField(phoneNuberTextField, padding: 10)
        addPaddingToTextField(cityTextField, padding: 10)
        addPaddingToTextField(addressTextField, padding: 10)
        addPaddingToTextField(zipcodeTextField, padding: 10)
        
        let textFields: [UITextField] = [nameTextField, phoneNuberTextField,cityTextField,addressTextField,zipcodeTextField ]
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
            cityTextField.becomeFirstResponder()
        case cityTextField:
            addressTextField.becomeFirstResponder()
        case addressTextField:
            zipcodeTextField.becomeFirstResponder()
        default:
            view.endEditing(true)
        }
        return true
    }
}


