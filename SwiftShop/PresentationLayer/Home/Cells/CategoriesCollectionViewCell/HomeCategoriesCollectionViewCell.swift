//
//  HomeCategoriesCollectionViewCell.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 24/11/2024.
//

import UIKit
import Kingfisher

class HomeCategoriesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - PROPIRITES
    static let identifier = String(describing: HomeCategoriesCollectionViewCell.self)
    
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
}
extension  HomeCategoriesCollectionViewCell {
    func setup(category: Category) {
        let imageUrl = category.image.asUrl
        imageView.kf.setImage(with: imageUrl)
        categoryLabel.text = category.name

    }
}
