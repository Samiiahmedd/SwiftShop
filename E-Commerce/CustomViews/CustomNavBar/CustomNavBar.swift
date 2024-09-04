//
//  CustomNavBar.swift
//  E-Commerce
//
//  Created by Abdalazem Saleh on 04/09/2024.
//

import UIKit

class CustomNavBar: UIView {
    
    // MARK: - IBOUTLET
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var firstTralingButton: UIButton!

    // MARK: - PROPERTYS
    
    private var firstTralingButtonAction: (() -> Void)?
    
    // MARK: - INITLIZER
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    // MARK: - IBACTIONS
            
    @IBAction func firstTralingButton(_ sender: UIButton) {
        firstTralingButtonAction?()
    }
}

// MARK: - CUSTOM NAV BAR CALL FUNCTIONS

extension CustomNavBar {
    func setupFirstTralingButton(with title: String, and image: UIImage, with action: @escaping () -> Void) {
        configureTralingButton(with: title, and: image, with: action)
    }
}

// MARK: - CUSTOM NAV BAR FUNCTIONS

private extension CustomNavBar {
    func nibSetup() {
        backgroundColor = .red
        containerView = loadViewFromNib()
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(containerView)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return UIView() }
        return nibView
    }
    
    func configureTralingButton(with title: String, and image: UIImage, with action: @escaping () -> Void) {
        firstTralingButton.isHidden = false
        firstTralingButtonAction = action
        firstTralingButton.setTitle(title, for: .normal)
        firstTralingButton.setImage(image, for: .normal)
    }
}
