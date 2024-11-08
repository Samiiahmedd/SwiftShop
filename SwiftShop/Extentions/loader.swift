//
//  loader.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 30/09/2024.
//


import UIKit

extension UIViewController {
    private struct AssociatedKeys {
        static var loaderKey = "loaderKey"
    }
    
    private var loaderAlert: UIAlertController? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.loaderKey) as? UIAlertController
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.loaderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func showLoader() {
        let alert = UIAlertController(title: nil, message: "Processing..", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.style = .large
        alert.view.addSubview(indicator)
        
        loaderAlert = alert
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoader() {
        loaderAlert?.dismiss(animated: true, completion: nil)
        loaderAlert = nil
    }
}

