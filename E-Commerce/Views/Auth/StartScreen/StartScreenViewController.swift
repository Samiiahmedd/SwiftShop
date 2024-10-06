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
    
    var coordinator: AuthCoordinatorProtocol?
    
    //MARK: -ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -IBAction
    @IBAction func loginBtn(_ sender: Any) {
        coordinator?.displayLogin()
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        coordinator?.displaySignup()
    }
}
