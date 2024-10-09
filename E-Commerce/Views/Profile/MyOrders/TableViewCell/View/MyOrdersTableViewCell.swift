//
//  MyOrdersTableViewCell.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 10/10/2024.
//

import UIKit

class MyOrdersTableViewCell: UITableViewCell {
    
    //MARK: - @IBOUTLETS
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var qualityLabel: UILabel!
    @IBOutlet weak var qualityCount: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizeType: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var productPrice: UILabel!
    
    //MARK: - VARIABLES
    
    static let identifier =  "MyOrdersTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "MyOrdersTableViewCell", bundle: nil)
    }
}

// MARK: - SETUP CELL

extension MyOrdersTableViewCell {
    func setup(Myorders:MyOrdersModel) {
        productImage.image = Myorders.productImage
        productName.text = Myorders.productName
        productDescription.text = Myorders.productDescription
        qualityCount.text = String(Myorders.productQuality)
        sizeType.text = Myorders.productSize
        colorView.backgroundColor = Myorders.productColor
    }
}
