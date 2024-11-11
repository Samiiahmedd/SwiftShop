//
//  NewArriivalCollectionViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 03/09/2024.
//

import UIKit
import Kingfisher

protocol NewArrivalCollectionViewCellDelegate: AnyObject {
    func didTapFavoriteButton(on cell: NewArriivalCollectionViewCell)
}

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
    
    // MARK: - Delegate
    
    weak var delegate: NewArrivalCollectionViewCellDelegate?
    
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

extension NewArriivalCollectionViewCell {
    func Setup(newArrival: Product) {
        let imageUrl = newArrival.image.asUrl
            imageView.kf.setImage(with: imageUrl)
        productTitleLabel.text = newArrival.name
        productType.text = newArrival.name
        productPrice.text = "$\(newArrival.price)"

    }
}
