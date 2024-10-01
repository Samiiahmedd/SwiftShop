//
//  ResetPasswordSuccessViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 01/10/2024.
//

import UIKit

class ResetPasswordSuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func loginButton(_ sender: Any) {
        let login = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(login, animated: true)
        self.navigationItem.hidesBackButton = true    }
    
    

}
