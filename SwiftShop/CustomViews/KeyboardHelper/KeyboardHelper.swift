//
//  KeyboardHelper.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 15/10/2024.
//

import UIKit

extension UIViewController {
    
    func configureKeyboardHandling() {
        // Listen for keyboard appearance
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // Listen for keyboard disappearance
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardSize.cgRectValue.height
            self.view.frame.origin.y = -keyboardHeight / 2
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        // Reset the view to its original position when the keyboard hides
        self.view.frame.origin.y = 0
    }
    
    func removeKeyboardHandling() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
