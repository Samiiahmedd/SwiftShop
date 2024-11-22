//
//  ImageCollectionViewCell.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 12/11/2024.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOUTLETS
    
    @IBOutlet weak var imageCell: UIImageView!
    
    // MARK: - Properties
    
    static let identifier = String(describing: ImageCollectionViewCell.self)

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

//MARK: - Extensions

extension ImageCollectionViewCell {
    func setup(image: String) {
        let imageUrl = image.asUrl
        imageCell.kf.setImage(with: imageUrl)
    }
}

