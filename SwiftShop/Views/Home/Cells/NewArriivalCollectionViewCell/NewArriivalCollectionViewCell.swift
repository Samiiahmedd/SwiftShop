//
//  NewArriivalCollectionViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 03/09/2024.
//

import UIKit
import Kingfisher

class NewArriivalCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Variables
    
    static let identifier = String(describing: NewArriivalCollectionViewCell.self)
    
    //MARK: - IBoutlets
    
    @IBOutlet var view: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var favouriteButton: UIButton!
    @IBOutlet var productTitleLabel: UILabel!
    @IBOutlet var productType: UILabel!
    @IBOutlet var productPrice: UILabel!
    
    //MARK: - ViewLifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - IBActions
    
    @IBAction func favouriteButton(_ sender: Any) {
        // Add product to favourites
    }
}

// MARK: - SETUP CELL

extension NewArriivalCollectionViewCell {
    func Setup(newArrival: NewArrival) {
        let imageUrl = newArrival.image.asUrl 
            imageView.kf.setImage(with: imageUrl)

        productTitleLabel.text = newArrival.title
        productType.text = newArrival.category
        productPrice.text = "$\(newArrival.price)"

    }
}
