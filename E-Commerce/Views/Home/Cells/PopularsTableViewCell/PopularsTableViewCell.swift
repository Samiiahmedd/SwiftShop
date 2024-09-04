//
//  PopularsTableViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/09/2024.
//

import UIKit

class PopularsTableViewCell: UITableViewCell {

    //MARK: -IBoutlets
    
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productTitle: UILabel!
    @IBOutlet var productDescription: UILabel!
    @IBOutlet var productRating: UILabel!
    @IBOutlet var productPrice: UILabel!
    
    // MARK: - variables

    static let identifier =  "PopularsTableViewCell"
    static func nib() -> UINib {
           return UINib(nibName: "PopularsTableViewCell", bundle: nil)
       }
    
    //MARK: -ViewLifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - SETUP CELL

extension PopularsTableViewCell {
    func Setup(Populars: PopularModel) {
        productImage.image = Populars.popularImage
        productTitle.text = Populars.popularTitle
        productDescription.text = Populars.popularDescription
        productRating.text = Populars.popularRating
        productPrice.text = Populars.popularPrice
    }
}
