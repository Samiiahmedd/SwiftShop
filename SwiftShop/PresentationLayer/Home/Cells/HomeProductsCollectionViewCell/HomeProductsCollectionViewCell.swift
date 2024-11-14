//
//  HomeProductsCollectionViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 03/09/2024.
//

import UIKit
import Kingfisher

protocol HomeProductsCollectionViewCellDelegate: AnyObject {
    func didTapFavoriteButton(on cell: HomeProductsCollectionViewCell)
}

class HomeProductsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Variables
    
    static let identifier = String(describing: HomeProductsCollectionViewCell.self)
    
    //MARK: - IBoutlets
    
    @IBOutlet var view: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var favouriteButton: UIButton!
    @IBOutlet var productTitleLabel: UILabel!
    @IBOutlet var productType: UILabel!
    @IBOutlet var productPrice: UILabel!
    
    // MARK: - Delegate
    
    weak var delegate: HomeProductsCollectionViewCellDelegate?
    
    //MARK: - ViewLifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - IBActions
    
    @IBAction func favouriteButton(_ sender: Any) {
        delegate?.didTapFavoriteButton(on: self)
    }
}

// MARK: - SETUP CELL

extension HomeProductsCollectionViewCell {
    func Setup(product: ProductDisplayable) {
        let imageUrl = product.image.asUrl
            imageView.kf.setImage(with: imageUrl)
        productTitleLabel.text = product.name
        productPrice.text = "$\(product.price)"
        let oldPriceText = "$\(product.old_price)"
                let attributedOldPrice = NSAttributedString(
                    string: oldPriceText,
                    attributes: [
                        .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                        .strikethroughColor: UIColor.red
                    ]
                )
                productType.attributedText = attributedOldPrice
                productPrice.text = "$\(product.price)"
            }

    }

