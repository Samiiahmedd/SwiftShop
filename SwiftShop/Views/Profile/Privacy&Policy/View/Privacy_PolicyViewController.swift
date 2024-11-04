//
//  Privacy&PolicyViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 12/10/2024.
//

import UIKit

class Privacy_PolicyViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

//MARK: - SETUPVIEW

extension Privacy_PolicyViewController {
    func setupView() {
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
