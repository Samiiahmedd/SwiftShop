//
//  StartScreenViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 18/07/2024.
//

import UIKit

class StartScreenViewController: UIViewController {

    //MARK: -IBOUtlet
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!
    
    //MARK: -ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -IBAction
    @IBAction func loginBtn(_ sender: Any) {
        let LoginVC = LoginViewController()
        self.navigationController?.pushViewController(LoginVC, animated: true)
        
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        let SignUpVC = SignUpViewController()
        self.navigationController?.pushViewController(SignUpVC, animated: true)
    }
}
