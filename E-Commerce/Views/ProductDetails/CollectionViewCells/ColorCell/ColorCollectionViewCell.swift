//
//  ColorCollectionViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 18/09/2024.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var colorButton: UIButton!
    
    @IBOutlet weak var checkmarkImageView: UIImageView!
    //MARK: - VARIABLES
    
    static let identifier = String(describing: ColorCollectionViewCell.self)
    
    
    //MARK: - VIEW LIFE CYCLE
    override func awakeFromNib() {
        super.awakeFromNib()
        checkmarkImageView.isHidden = true
        checkmarkImageView.tintColor = UIColor.black
    }
    
    // MARK: - Functions
    
    func configure(with color: UIColor, isSelected: Bool) {
        print("Configuring cell with color: \(color) and isSelected: \(isSelected)")
        colorButton.backgroundColor = color
        checkmarkImageView.image = isSelected ? UIImage(systemName: "checkmark.circle.fill") : nil
        checkmarkImageView.tintColor = isSelected ? .white : nil
    }
    
    func setSelected(_ selected: Bool) {
        print("Selected: \(selected)")
        checkmarkImageView.isHidden = !selected
        if selected {
            colorButton.layer.borderWidth = 2
            colorButton.layer.borderColor = UIColor.black.cgColor
            checkmarkImageView.image = UIImage(systemName: "checkmark.circle.fill")
        } else {
            colorButton.layer.borderWidth = 0
            checkmarkImageView.image = nil
        }
    }
}

