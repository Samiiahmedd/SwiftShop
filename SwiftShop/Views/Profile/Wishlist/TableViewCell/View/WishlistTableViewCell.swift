//
//  WishlistTableViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 02/10/2024.
//

import UIKit
import Kingfisher

class WishlistTableViewCell: UITableViewCell {
    
    //MARK: - @IBOUTLETS
 
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - VARIABLES

    static let identifier = "WishlistTableViewCell"
    static func nib() -> UINib {
           return UINib(nibName: "WishlistTableViewCell", bundle: nil)
       }
    
//MARK: - VIEW LIFE CYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - SETUP CELL

extension WishlistTableViewCell {
    func Setup(Wishlist: ProductDetailsModel) {
        
        let imageUrl = Wishlist.image.asUrl
        productImage.kf.setImage(with: imageUrl, placeholder:UIImage(systemName: "photo.artframe"))

        productTitle.text = Wishlist.title
        productDescription.text = Wishlist.category
        productPrice.text = String(Wishlist.price)
    }
}
