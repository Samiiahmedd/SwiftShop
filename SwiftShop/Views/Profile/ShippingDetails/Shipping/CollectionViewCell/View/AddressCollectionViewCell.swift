//
//  AddressCollectionViewCell.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 11/10/2024.
//

import UIKit

class AddressCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOUTLETS
    
    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var zipLabel: UILabel!
}

//MARK: - SETUP

extension AddressCollectionViewCell{
    func setup(with address: Address) {
        nameLabel.text = "Name: \(address.name)"
        phoneLabel.text = "Phone: \(address.phone)"
        cityLabel.text = "City: \(address.city)"
        addressLabel.text = "Address: \(address.address)"
        zipLabel.text = "Address: \(address.zipCode)"
    }
}
