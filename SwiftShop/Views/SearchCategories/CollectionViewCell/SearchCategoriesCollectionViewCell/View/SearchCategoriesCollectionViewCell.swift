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
    func setup(category: String) { // Change the parameter type to String
        let imageName = modifyImageName(category)
        categoryImage.image = UIImage(named: imageName)
        categoryTitle.text = category
        categoryCount.text = modifyCount(category)
    }
}

//MARK: - FUNCTIONS

///HANDLE UNPUTTED DATA IN API ..

private func modifyImageName(_ name: String) -> String {
        switch name {
        case "men's clothing":
            return "first"
        case "women's clothing":
            return "Womens"
        case "Bags":
            return "third"
        case "Shoses":
            return "shoes"
        case "electronics":
            return "fifth"
        case "jewelery":
            return "jewelry"
        default:
            return "default_image"
        }
    }

private func modifyCount(_ count: String) -> String {
        switch count {
        case "men's clothing":
            return "7 products"
        case "women's clothing":
            return "10 products"
        case "Bags":
            return "4 products"
        case "Shoses":
            return "5 products"
        case "electronics":
            return "8 products"
        case "jewelery":
            return "6 products"
        default:
            return "0 products"
        }
    }

