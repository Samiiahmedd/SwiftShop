//
//  SearchCategoriesCollectionViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/09/2024.
//

import UIKit

class SearchCategoriesCollectionViewCell: UICollectionViewCell {
    
    //MARK: -IBOUtlet
    
    @IBOutlet var categoryImage: UIImageView!
    @IBOutlet var categoryTitle: UILabel!
    @IBOutlet var categoryCount: UILabel!
    
    //MARK: -Variables
    
    static let identifier = String(describing: SearchCategoriesCollectionViewCell.self)
    
    //MARK: -ViewLifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}


//MARK: -SETUP CELL

extension SearchCategoriesCollectionViewCell {
    func Setup(categories: SearchCategoriesModel) {
        categoryImage.image = categories.categoryImage
        categoryTitle.text = categories.categoryTitle
        categoryCount.text = categories.categoryCount
    }
}
