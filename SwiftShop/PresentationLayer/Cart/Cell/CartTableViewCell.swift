//
//  CartTableViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 24/09/2024.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    //MARK: - IBOUTLET
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var stepperView: StapperView!
    
    // MARK: - variables
    
    static let identifier =  "CartTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "CartTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

// MARK: - SETUP CELL

extension CartTableViewCell {
    func Setup(cartItem: inCartItem) {
        let imageUrl = cartItem.product.image.asUrl
        productImage.kf.setImage(with: imageUrl)
        productName.text = cartItem.product.name
        productPrice.text = "Price: \(cartItem.product.price) $"
        productDescription.text = cartItem.product.description
        stepperView.configure(with: cartItem.quantity)
    }
}
