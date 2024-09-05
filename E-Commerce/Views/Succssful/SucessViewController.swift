//
//  SucessViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/08/2024.
//

import UIKit

class SucessViewController: UIViewController {
    
    //MARK: -ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -IBActions
    @IBAction func startShoppingBtn(_ sender: Any) {
        let Home = HomeVC()
        Home.modalPresentationStyle = .overFullScreen
        Home.modalTransitionStyle = .crossDissolve
        self.present(Home, animated: true)    }
    
    
    
}
