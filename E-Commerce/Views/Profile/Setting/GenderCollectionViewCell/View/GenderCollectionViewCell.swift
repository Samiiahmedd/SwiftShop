//
//  GenderCollectionViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 09/10/2024.
//

import UIKit

class GenderCollectionViewCell: UICollectionViewCell {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    //MARK: - VARIABLES
    
    static let identifier = String(describing: GenderCollectionViewCell.self)
}

// MARK: - SETUP CELL

extension GenderCollectionViewCell {
    func Setup (genderType:GenderModel) {
        gender.text = genderType.gender
    }
}
