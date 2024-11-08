//
//  CategoriesCollectionViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 22/09/2024.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOUTLETS
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var categoryName: UILabel!
    
    //MARK: - VARIABLES
    
    static let identifier = String(describing: CategoriesCollectionViewCell.self)
    
    //MARK: - ViewLifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

// MARK: - SETUP CELL

extension CategoriesCollectionViewCell {
    func Setup (category:CategoriesModel) {
        categoryName.text = category.categoryName
    }
}
