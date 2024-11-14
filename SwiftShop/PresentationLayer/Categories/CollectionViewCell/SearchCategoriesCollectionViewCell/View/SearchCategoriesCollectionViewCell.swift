//
//  SearchCategoriesCollectionViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/09/2024.
//

import UIKit
import Kingfisher

class SearchCategoriesCollectionViewCell: UICollectionViewCell {
    
    //MARK: -IBOUtlet
    
    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var categoryTitle: UILabel!

    //MARK: -Variables
    
    static let identifier = String(describing: SearchCategoriesCollectionViewCell.self)
    
    //MARK: -ViewLifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

//MARK: -SETUP CELL

extension SearchCategoriesCollectionViewCell {
    func setup(category:Category) {
        let imageUrl = category.image.asUrl
        categoryImage.kf.setImage(with: imageUrl)
        categoryTitle.text = category.name
    }
}




