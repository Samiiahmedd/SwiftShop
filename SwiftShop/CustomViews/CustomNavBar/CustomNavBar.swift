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
    @IBOutlet weak var firstLeadingButton: UIButton!
    @IBOutlet weak var lastFirstTralingButton: UIButton!
    
    // MARK: - PROPERTYS
    
    private var firstTralingButtonAction: (() -> Void)?
    private var firstLeadingButtonAction: (() -> Void)?
    private var lastFirstTralingButtonAction: (() -> Void)?
    
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
    @IBAction func firstLeadingButtonAction(_ sender: Any) {
        firstLeadingButtonAction?()
    }
    
    @IBAction func lastFirstTrailingButtonAction(_ sender: Any) {
        lastFirstTralingButtonAction?()
    }
    
}

// MARK: - CUSTOM NAV BAR CALL FUNCTIONS

extension CustomNavBar {
    func setupFirstTralingButton(with title: String, and image: UIImage, with action: @escaping () -> Void) {
        configureTralingButton(with: title, and: image, with: action)
    }    
    func setupFirstLeadingButton(with title: String, and image: UIImage, with action: @escaping () -> Void) {
        configureLeadingButton(with: title, and: image, with: action)
    }
    func setupLastFirstTralingButton(with title: String, and image: UIImage, with action: @escaping () -> Void) {
        configureLastTralingButton(with: title, and: image, with: action)
    }
}

// MARK: - CUSTOM NAV BAR FUNCTIONS

private extension CustomNavBar {
    func nibSetup() {
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
    
    func configureLeadingButton(with title: String, and image: UIImage, with action: @escaping () -> Void) {
        firstLeadingButton.isHidden = false
        firstLeadingButtonAction = action
        firstLeadingButton.setTitle(title, for: .normal)
        firstLeadingButton.setImage(image, for: .normal)
    }
    
    func configureLastTralingButton(with title: String, and image: UIImage, with action: @escaping () -> Void) {
        lastFirstTralingButton.isHidden = false
        lastFirstTralingButtonAction = action
        lastFirstTralingButton.setTitle(title, for: .normal)
        lastFirstTralingButton.setImage(image, for: .normal)
    }
}
