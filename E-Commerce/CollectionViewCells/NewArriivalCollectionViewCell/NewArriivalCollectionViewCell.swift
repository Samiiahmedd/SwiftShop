    //
    //  NewArriivalCollectionViewCell.swift
    //  E-Commerce
    //
    //  Created by Sami Ahmed on 03/09/2024.
    //

    import UIKit

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
        
        //MARK: - Function
        
        func Setup(newArrival: NewArrivalModel) {
            imageView.image = newArrival.productImage
            productTitleLabel.text = newArrival.productTitle
            productType.text = newArrival.productType
            productPrice.text = newArrival.productPrice
        }
    }
