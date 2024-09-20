//
//  Fonts.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 18/07/2024.
//

import Foundation
import UIKit

extension UIFont {
    static private func fontName(forWeight weight: UIFont.Weight) -> String {
        switch weight {
        case .regular: return "PoppinsRegular"
        case .medium: return "PoppinsMedium"
        case .semibold: return "PoppinsSemiBold"
        case .bold: return "PoppinsBold"
        default: return "PoppinsRegular"
        }
    }
}
