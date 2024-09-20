//
//  SizeCollectionViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 17/09/2024.
//

import UIKit

class SizeCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizeView: UIView!
    
    //MARK: - VARIABLES
    
    static let identifier = String(describing: SizeCollectionViewCell.self)
    
    
    // MARK: - INITILIZER
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - SETUP CELL

extension SizeCollectionViewCell {
    func Setup(Size: SizeModel) {
        sizeLabel.text = Size.size
    }
}
