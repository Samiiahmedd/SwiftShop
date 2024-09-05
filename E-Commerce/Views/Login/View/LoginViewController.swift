//
//  LoginViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 19/07/2024.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {
    //MARK: -Variables
    
    
    //MARK: -IBOUtlet
    
    @IBOutlet var emailTxtFiedl: UITextField!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var passwordTxtField: UITextField!
    @IBOutlet var fbLogin: UIButton!
    @IBOutlet var appleLogin: UIButton!
    @IBOutlet var googleLogin: UIButton!
    
    //MARK: -ViewLifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -IBActions
    
    @IBAction func loginBtn(_ sender: Any) {
        guard let email = emailTxtFiedl.text, !email.isEmpty,
              let password = passwordTxtField.text, !password.isEmpty else {
            print("Email or password field is empty")
            return
        }
        
        // Firebase sign in
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
            } else {
                print("User signed in successfully")
                self.navigateToHomeVC()
            }
        }
    }
    
    @IBAction func fbLogin(_ sender: Any) {
        // Implement Facebook login logic here
    }
    
    @IBAction func appleLogin(_ sender: Any) {
        // Implement Apple login logic here
    }
    
    @IBAction func googleLogin(_ sender: Any) {
        // Implement Google login logic here
    }
    
    // MARK: - Navigation
       
       private func navigateToHomeVC() {
           // Create an instance of HomeVC
           let Success = SucessViewController()
           Success.modalPresentationStyle = .overFullScreen
           Success.modalTransitionStyle = .crossDissolve
           self.present(Success, animated: true)
       }
   
}


