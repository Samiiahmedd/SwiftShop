//
//  ColorCollectionViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 18/09/2024.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var checkmark: UIImageView!
    
    //MARK: - VARIABLES
    
    static let identifier = String(describing: ColorCollectionViewCell.self)
    
    
    //MARK: - VIEW LIFE CYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Functions
    
    func configure(with color: UIColor) {
        containerView.backgroundColor = color
    }
}

