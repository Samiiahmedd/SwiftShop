//
//  CustomTabButtonViewController.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 15/10/2024.
//

import UIKit

class CustomTabButtonView: UIView {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var iconName: UILabel!
    
    //MARK: - VARIABLES
    
    var isSelectedTab: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    func configure(image: UIImage, name: String) {
        iconImage.image = image
        iconName.text = name
        updateAppearance()
    }
    
    //MARK: - VIEW LIFE CYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadNib()
        updateAppearance()
    }
    
    func loadNib() {
        if let loadedViews = Bundle.main.loadNibNamed("CustomTabButtonView", owner: self, options: nil),
           let view = loadedViews.first as? UIView {
            addSubview(view)
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    func updateAppearance() {
        iconName.isHidden = !isSelectedTab
        iconName.textColor = isSelectedTab ? .black : .gray
        iconImage.tintColor = isSelectedTab ? .black : .gray
    }
}
