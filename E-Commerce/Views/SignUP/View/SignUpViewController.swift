//
//  SignUpViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 03/08/2024.
//

import UIKit
import Firebase
import FirebaseAuth

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
        guard let name = nameTxtField.text, !name.isEmpty,
              let email = emailTxtField.text, !email.isEmpty,
              let password = passwordTxtField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordTxtField.text, !confirmPassword.isEmpty else {
            print("All fields are required")
            return
        }
        
        guard password == confirmPassword else {
            print("Passwords do not match")
            return
        }
        
        // Create a new user with Firebase Auth
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Failed to create user: \(error.localizedDescription)")
            } else {
                print("User created successfully")
                
                // Set the user's display name
                
                if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                    changeRequest.displayName = name
                    changeRequest.commitChanges { error in
                        if let error = error {
                            print("Failed to update display name: \(error.localizedDescription)")
                        } else {
                            print("Display name updated successfully")
                            // Navigate to the next screen or handle post-sign-up logic
                        }
                    }
                }
            }
        }
    }
}
