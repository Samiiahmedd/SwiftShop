//
//  NotificationsControllViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 16/10/2024.
//

import UIKit

class NotificationsControllViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var navBar: CustomNavBar!
    @IBOutlet weak var notificationsLabel: UILabel!
    @IBOutlet weak var notificationsSwitch: UISwitch!
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func notificationsSwitchAction(_ sender: Any) {
    }
}

//MARK: - SETUPVIEW

extension NotificationsControllViewController {
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
