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
    func setup(categories: Category) {
        let imageName = modifyImageName(categories.name)
                categoryImage.image = UIImage(named: imageName)
        categoryTitle.text = categories.name
        categoryCount.text = modifyCount(categories.name)
        
    }
}

//MARK: - FUNCTIONS
///HANDLE UNPUTTED DATA IN API ..

private func modifyImageName(_ name: String) -> String {
        switch name {
        case "Clothing":
            return "first"
        case "Clothes":
            return "first"
        case "Bags":
            return "third"
        case "Shoses":
            return "shoes"
        case "Electronics":
            return "fifth"
        case "Jewelry":
            return "jewelry"
        default:
            return "default_image"
        }
    }

private func modifyCount(_ count: String) -> String {
        switch count {
        case "Clothing":
            return "7 products"
        case "Clothes":
            return "5 products"
        case "Bags":
            return "4 products"
        case "Shoses":
            return "5 products"
        case "Electronics":
            return "58 products"
        case "Jewelry":
            return "6 products"
        default:
            return "0 products"
        }
    }

