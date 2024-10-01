//
//  TextFieldPadding.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 01/10/2024.
//

import Foundation
import UIKit

func addPaddingToTextField(_ textField: UITextField, padding: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: textField.frame.height))
    textField.leftView = paddingView
    textField.leftViewMode = .always
}
