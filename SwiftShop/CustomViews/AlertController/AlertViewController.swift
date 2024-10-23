//
//  AlertViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 24/10/2024.
//

import UIKit

class AlertViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var alertMessageLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    // MARK: - Variables
    
    var alertImage: UIImage?
    var alertTitle: String?
    var alertMessage: String?
    var buttonTitle: String?
    var buttonAction: (() -> Void)?
    
    //MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction func okButtonAction(_ sender: UIButton) {
        dismiss(animated: true) {
            self.buttonAction?()
        }
    }
    
}

//MARK: - SETUP

extension AlertViewController {
    func setupView() {
        setupAlert()
    }
    func setupAlert() {
        imageView.image = alertImage
        alertTitleLabel.text = alertTitle
        alertMessageLabel.text = alertMessage
        okButton.setTitle(buttonTitle, for: .normal)
    }
    
    static func showAlert(on viewController: UIViewController, image: UIImage, title: String, message: String, buttonTitle: String, action: @escaping () -> Void) {
        let alertVC = AlertViewController.instantiateFromXIB()!
        alertVC.alertImage = image
        alertVC.alertTitle = title
        alertVC.alertMessage = message
        alertVC.buttonTitle = buttonTitle
        alertVC.buttonAction = action
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve 
        viewController.present(alertVC, animated: true, completion: nil)
    }
}
