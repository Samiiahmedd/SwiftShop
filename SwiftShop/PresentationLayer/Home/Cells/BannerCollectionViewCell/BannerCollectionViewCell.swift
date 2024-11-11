//
//  BannerCollectionViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 02/09/2024.
//

import UIKit
import Kingfisher

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
    func Setup(banner: Banner) {
        let imageUrl = banner.image.asUrl
        bannerImageView.kf.setImage(with: imageUrl)
    }
}
