//
//  DarkModeViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 16/10/2024.
//

import UIKit

class DarkModeViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    
    @IBOutlet weak var darkModelLabel: UILabel!
    
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func darkModeSwitchAvtion(_ sender: Any) {
    }
}

//MARK: - SETUPVIEW

extension DarkModeViewController {
    func setupView(){
        configureNavBar()
    }
    
    func configureNavBar() {
        navBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) {
            self.navigationController?.popViewController(animated: true)
        }
        navBar.firstTralingButton.isHidden = true
        navBar.lastFirstTralingButton.isHidden = true
    }
}
