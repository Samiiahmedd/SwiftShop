//
//  Alert.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 25/06/1403 AP.
//

import UIKit

extension UIViewController {
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}
