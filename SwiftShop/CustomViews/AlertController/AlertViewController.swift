//
//  AlertViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 24/10/2024.
//

import UIKit

@MainActor
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
        dismissAlertWithTimer()
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
        DispatchQueue.main.async {
            print("Presenting alert now")
            guard let alertVC = AlertViewController.instantiateFromXIB() else {
                print("Failed to instantiate AlertViewController")
                return
            }
            alertVC.alertImage = image
            alertVC.alertTitle = title
            alertVC.alertMessage = message
            alertVC.buttonTitle = buttonTitle
            alertVC.buttonAction = action
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            print("About to present alert on view controller: \(viewController)")
            viewController.present(alertVC, animated: true, completion: nil)
        }
    }


    
    private func dismissAlertShape() {
            UIView.animate(withDuration: 0.5, animations: {
                self.mainView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                self.mainView.alpha = 0
            }) { _ in
                self.dismiss(animated: false) {
                    self.buttonAction?()
                }
            }
        }
    
    func dismissAlertWithTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                  self.dismissAlertShape()
              }
    }
}
