//
//  OTPViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 01/10/2024.
//

import UIKit
import Combine

class OTPViewController: UIViewController, UITextFieldDelegate, OTPFieldDelegate {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var txtOtp1: OTPTextField!
    @IBOutlet weak var txtOtp2: OTPTextField!
    @IBOutlet weak var txtOtp3: OTPTextField!
    @IBOutlet weak var txtOtp4: OTPTextField!
    @IBOutlet weak var txtOtp5: OTPTextField!
    @IBOutlet weak var txtOtp6: OTPTextField!
    @IBOutlet weak var veifyButton: UIButton!
    
    
    // MARK: - VARIABLES
    var email: String?
    private var viewModel: OTPViewModelProtocol = OTPViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindViewModel()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func verifyCodeButton(_ sender: Any) {
        let otp = "\(txtOtp1.text ?? "")\(txtOtp2.text ?? "")\(txtOtp3.text ?? "")\(txtOtp4.text ?? "")\(txtOtp5.text ?? "")\(txtOtp6.text ?? "")"
        
        guard otp.count == 6 else {
            showErrorAlert(message: "Please enter a complete OTP.")
            return
        }
         if let email = self.email {
             Task {
                 await viewModel.verifyOTP(with: otp, email: email)
             }
         } else {
             showErrorAlert(message: "Make sure that OTP Is Correct Or Valid")
         }
     }
    
    //Text Fields Set
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case txtOtp1:
            if string.isEmpty {
                txtOtp1.text = string
            } else {
                //restrict to only numbersf
                if let _ = Int(string) {
                    txtOtp1.text = string
                    txtOtp2.becomeFirstResponder()
                }
            }
        case txtOtp2:
            if string.isEmpty {
                txtOtp2.text = string
                txtOtp1.becomeFirstResponder()
            } else {
                //restrict to only numbers
                if let _ = Int(string) {
                    txtOtp2.text = string
                    txtOtp3.becomeFirstResponder()
                }
            }
        case txtOtp3:
            if string.isEmpty {
                txtOtp3.text = string
                txtOtp2.becomeFirstResponder()
            } else {
                //restrict to only numbers
                if let _ = Int(string) {
                    txtOtp3.text = string
                    txtOtp4.becomeFirstResponder()
                }
            }
        case txtOtp4:
            if string.isEmpty {
                txtOtp4.text = string
                txtOtp3.becomeFirstResponder()
            } else {
                //restrict to only numbers
                if let _ = Int(string) {
                    txtOtp4.text = string
                    txtOtp5.becomeFirstResponder()

                }
            }        
        case txtOtp5:
            if string.isEmpty {
                txtOtp5.text = string
                txtOtp4.becomeFirstResponder()
            } else {
                //restrict to only numbers
                if let _ = Int(string) {
                    txtOtp5.text = string
                    txtOtp6.becomeFirstResponder()
                }
            }       
        case txtOtp6:
            if string.isEmpty {
                txtOtp6.text = string
                txtOtp5.becomeFirstResponder()
            } else {
                //restrict to only numbers
                if let _ = Int(string) {
                    txtOtp6.text = string

                }
            }
        default:
            return false
        }
        return false
    }
    
    func backwardDetected(textField: OTPTextField) {
        switch textField{
        case txtOtp1:
            print("txtOtp1 --> no change")
        case txtOtp2:
            txtOtp1.becomeFirstResponder()
        case txtOtp3:
            txtOtp2.becomeFirstResponder()
        case txtOtp4:
            txtOtp3.becomeFirstResponder()
        case txtOtp5:
            txtOtp4.becomeFirstResponder() 
        case txtOtp6:
            txtOtp5.becomeFirstResponder()
        default:
            print("at default")
        }
    }
}

//MARK: - SETUP VIEW

private extension OTPViewController {
    func setupView() {
        configureNavBar()
        configureOTP()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "",
                                       and: UIImage(named: "back")!) {
            let login = LoginViewController(nibName: "LoginViewController", bundle: nil)
            self.navigationController?.pushViewController(login, animated: true)
            self.navigationItem.hidesBackButton = true
        }
        navBar.firstTralingButton.isHidden = true
    }
    
    func configureOTP(){
        txtOtp1.delegate = self
        txtOtp2.delegate = self
        txtOtp3.delegate = self
        txtOtp4.delegate = self
        txtOtp5.delegate = self
        txtOtp6.delegate = self
        
        txtOtp1.backDelegate = self
        txtOtp2.backDelegate = self
        txtOtp3.backDelegate = self
        txtOtp4.backDelegate = self
        txtOtp5.backDelegate = self
        txtOtp6.backDelegate = self
    }
}

 extension OTPViewController {
    
    func bindViewModel() {
            bindIsLoading()
            bindErrorState()
            bindIsVerified()
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
        
        func bindIsVerified() {
            viewModel.isVerified.sink { [weak self] isVerified in
                guard let self = self else { return }
                let updatePassVC = UpdatePasswordViewController(nibName: "UpdatePasswordViewController", bundle: nil)
                updatePassVC.email = self.email
                self.navigationController?.pushViewController(updatePassVC, animated: true)
                self.navigationItem.hidesBackButton = true
            }.store(in: &cancellable)
        }
    }

//MARK: - to detect backspace in empty textfield

protocol OTPFieldDelegate: AnyObject {
   func backwardDetected(textField: OTPTextField)
}

class OTPTextField: UITextField {
   weak var backDelegate: OTPFieldDelegate?

   override func deleteBackward() {
     super.deleteBackward()

     self.backDelegate?.backwardDetected(textField: self)
   }
}
