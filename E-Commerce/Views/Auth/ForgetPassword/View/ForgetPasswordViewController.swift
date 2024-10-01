//
//  ForgetPasswordViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 30/09/2024.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var navBar: CustomNavBar!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: - VARIABLES

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    
    //MARK: - IBACTIONS
    @IBAction func nextButtonAction(_ sender: Any) {
        let otp = OTPViewController(nibName: "OTPViewController", bundle: nil)
        self.navigationController?.pushViewController(otp, animated: true)
        self.navigationItem.hidesBackButton = true
    }
}


// MARK: - SETUP VIEW

private extension ForgetPasswordViewController {
    func setupView() {
        configureNavBar()
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
}
