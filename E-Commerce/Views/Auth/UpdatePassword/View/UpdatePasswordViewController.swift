//
//  UpdatePasswordViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 01/10/2024.
//

import UIKit

class UpdatePasswordViewController: UIViewController {
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var updatePasswordButton: UIButton!
    
    //MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func updatePasswordButtonActiion(_ sender: Any) {
        let Success = ResetPasswordSuccessViewController(nibName: "ResetPasswordSuccessViewController", bundle: nil)
        self.navigationController?.pushViewController(Success, animated: true)
        self.navigationItem.hidesBackButton = true
        
    }
    
}

//MARK: - SETUP VIEW

private extension UpdatePasswordViewController {
    func setupView() {
        configureNavBar()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "",
                                       and: UIImage(named: "back")!) {
            let otp = OTPViewController(nibName: "OTPViewController", bundle: nil)
            self.navigationController?.pushViewController(otp, animated: true)
            self.navigationItem.hidesBackButton = true
        }
        navBar.firstTralingButton.isHidden = true
    }
    
    
}

