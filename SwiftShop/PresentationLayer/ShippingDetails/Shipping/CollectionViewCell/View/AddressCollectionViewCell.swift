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
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var selectionIndicator: UIView!

    //MARK: - PROPIRITES
    
    static let identifier = String(describing: AddressCollectionViewCell.self)
    
}

//MARK: - EXTENSIONS

extension AddressCollectionViewCell {
    func setup(address: AddressData) {
        nameLabel.text = "Name: \(address.name)"
        details.text = "Address details: \(address.details)"
        city.text = "City: \(address.city)"
        region.text = "Region: \(address.region)"
        notes.text = "Notes: \(address.notes)"
    }
    
    func setSelectedState(_ isSelected: Bool) {
            if isSelected {
                selectionIndicator.backgroundColor = .lightGray
            } else {
                selectionIndicator.backgroundColor = .clear
            }
        }
}

