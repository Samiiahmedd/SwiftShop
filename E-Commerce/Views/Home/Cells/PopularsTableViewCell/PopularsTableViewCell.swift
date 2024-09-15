//
//  PopularsTableViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/09/2024.
//

import UIKit

class PopularsTableViewCell: UITableViewCell {

    //MARK: -IBoutlets
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productRating: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    // MARK: - variables

    static let identifier =  "PopularsTableViewCell"
    static func nib() -> UINib {
           return UINib(nibName: "PopularsTableViewCell", bundle: nil)
       }
    
    //MARK: -ViewLifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        conigureViewShadow()
        self.selectionStyle = .none
    }
    
    func conigureViewShadow() {
        mainView.layer.cornerRadius = 8
        mainView.layer.masksToBounds = false
        
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainView.layer.shadowRadius = 5
        mainView.layer.shadowOpacity = 0.3
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
