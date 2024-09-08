//
//  CartCollectionViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/09/2024.
//

import UIKit

class CartCollectionViewCell: UICollectionViewCell {
    @IBOutlet var stepperView: StapperView!
    
    static let identifier = "CartCollectionViewCell"

    @IBOutlet var productImage: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var descLabel: UILabel!
    
    
    @IBOutlet var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func deleteButton(_ sender: Any) {
    }
}
//MARK: - Extention

extension CartCollectionViewCell {
    func Setup(cart: CartProductModel) {
        productImage.image = cart.productImage
        titleLabel.text = cart.productTitle
        descLabel.text = cart.productDescription
        priceLabel.text = cart.productPrice
    }
}
