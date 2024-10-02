//
//  ResetPasswordSuccessViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 01/10/2024.
//

import UIKit

class ResetPasswordSuccessViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func loginButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
