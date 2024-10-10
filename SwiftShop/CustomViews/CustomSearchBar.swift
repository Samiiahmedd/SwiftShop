//
//  CustomSearchBar.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 22/09/2024.
//

import UIKit

class CustomSearchBar: UIView {
    
    //MARK: - VIEWLIFECYCLE
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet var containerView: UIView!
    
    // MARK: - INITLIZER

    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
  
}
// MARK: - CUSTOM NAV BAR FUNCTIONS

private extension CustomSearchBar {
    func nibSetup() {
        containerView = loadViewFromNib()
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.translatesAutoresizingMaskIntoConstraints = true
       addPaddingToTextField(searchTextField, padding: 40)
        
        addSubview(containerView)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return UIView() }
        return nibView
    }
}
