//
//  PopularsCollectionViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 03/09/2024.
//

import UIKit

class PopularsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Variables
    
    static let identifier = String(describing: PopularsCollectionViewCell.self)
    
    //MARK: - IBOutlets
    
    @IBOutlet var productImage: UIImageView!
    
    @IBOutlet var productTitle: UILabel!
    
    @IBOutlet var productDescription: UILabel!
    
    @IBOutlet var productRating: UILabel!
    
    @IBOutlet var productPrice: UILabel!
    
    //MARK: - ViewLifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Func
    func Setup(Populars: PopularModel) {
        productImage.image = Populars.popularImage
        productTitle.text = Populars.popularTitle
        productDescription.text = Populars.popularDescription
        productRating.text = Populars.popularRating
        productPrice.text = Populars.popularPrice
    }

}
