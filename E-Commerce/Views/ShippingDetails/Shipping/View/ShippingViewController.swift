//
//  ShippingViewController.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 04/10/2024.
//

import UIKit

class ShippingViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var nanBar: CustomNavBar!
    @IBOutlet weak var titsle: UILabel!
    @IBOutlet weak var addressView: UIView!
    
    @IBOutlet weak var addAddressLabel: UIButton!
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func addAddressAction(_ sender: Any) {
        
    }
    
    //MARK: - FUNCTIONS
    func setupNavBar() {
        nanBar.setupFirstLeadingButton(with: "", and: UIImage(named: "back")!) {
            print("Back")
        }
        nanBar.firstTralingButton.isHidden = true
    }
    
    
}


