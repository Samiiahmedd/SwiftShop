//
//  UIViewControllerExtention.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 25/06/1403 AP.
//

import UIKit

extension UIViewController {
    func navigateToHomeVC() {
        let Success = SucessViewController()
        Success.modalPresentationStyle = .overFullScreen
        Success.modalTransitionStyle = .crossDissolve
        self.present(Success, animated: true)
    }
    
    func handelEndEditing() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
       view.addGestureRecognizer(tap)
    }
        
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension UIViewController {
    static func instantiateFromXIB() -> Self? {
        return Self(nibName: String(describing: self), bundle: nil)
    }
}
