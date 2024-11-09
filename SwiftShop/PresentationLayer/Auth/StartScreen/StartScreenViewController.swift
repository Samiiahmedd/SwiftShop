//
//  StartScreenViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 18/07/2024.
//

import UIKit

class StartScreenViewController: UIViewController {
    
    //MARK: - VARIABLES
    
    var coordinator: AuthCoordinatorProtocol?

    //MARK: - IBOUTLETS
    
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var signUpBtn: UIButton!
    
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func loginBtn(_ sender: Any) {
        coordinator?.displayLogin()
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        coordinator?.displaySignup()
    }
}
