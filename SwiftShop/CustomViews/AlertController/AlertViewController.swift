//
//  AlertViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 24/10/2024.
//

import UIKit

class AlertViewController: UIViewController {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var messageView: UIView!
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
        addBlurEffect()
    }
    func setupAlert() {
        imageView.image = alertImage
        alertTitleLabel.text = alertTitle
        alertMessageLabel.text = alertMessage
        okButton.setTitle(buttonTitle, for: .normal)
    }
    
    private func addBlurEffect() {
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = mainView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            mainView.insertSubview(blurEffectView, at: 0)
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