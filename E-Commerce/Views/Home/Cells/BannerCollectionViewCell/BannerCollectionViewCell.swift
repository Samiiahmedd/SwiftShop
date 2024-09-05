//
//  BannerCollectionViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 02/09/2024.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    //MARK: -Variables
    
    static let identifier = String(describing: BannerCollectionViewCell.self)

  
    //MARK: - IBOutlet
    
    @IBOutlet var bannerImageView: UIImageView!
    
    
    //MARK: -ViewLifeCycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

//MARK: - Extention

extension BannerCollectionViewCell {
    func Setup(banner: BannerModel) {
        bannerImageView.image = banner.image

    }
}
