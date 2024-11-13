//
//  UIView+Extentions.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 17/07/2024.
//

import UIKit
import Foundation

extension UIView {
    
    // CornerRadius
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    // Shadow
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let color = self.layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    // Boarder
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let color = self.layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func applyRoundedShadow(cornerRadius: CGFloat, shadowColor: UIColor = .black, shadowOpacity: Float = 0.5, shadowOffset: CGSize = CGSize(width: 0, height: 2), shadowRadius: CGFloat = 4) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
    }
}

extension UIView {
    func startShimmering() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(white: 0.85, alpha: 1.0).cgColor,
            UIColor(white: 0.90, alpha: 1.0).cgColor,
            UIColor(white: 0.85, alpha: 1.0).cgColor
        ]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.locations = [0, 0.5, 1]
        self.layer.addSublayer(gradientLayer)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0, 0, 0.2]
        animation.toValue = [0.8, 1, 1]
        animation.duration = 0.8
        animation.repeatCount = .infinity
        gradientLayer.add(animation, forKey: "shimmer")
    }
    
    func stopShimmering() {
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
    }
}


