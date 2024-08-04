//
//  SignUpViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 03/08/2024.
//

import UIKit

class SignUpViewController: UIViewController {
    
    //MARK: -IBOUtlet
    @IBOutlet var nameTxtField: UITextField!
    @IBOutlet var emailTxtField: UITextField!
    @IBOutlet var confirmPasswordTxtField: UITextField!
    @IBOutlet var passwordTxtField: UITextField!
    
    //MARK: -ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -IBActions

    @IBAction func loginBtb(_ sender: Any) {
        let SucessVC = SucessViewController()
        self.navigationController?.pushViewController(SucessVC, animated: true)
    }
    


}
