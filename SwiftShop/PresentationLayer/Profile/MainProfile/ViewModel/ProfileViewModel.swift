//
//  ProfileViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 08/10/2024.
//

import Foundation
import UIKit

class ProfileViewModel {

    
    var ProfileHeaderTable : [ProfileTableViewCellModel] = [
        .init(image: UIImage(named: "My Order")!, title: "My Order"),
        .init(image: UIImage(named: "My Favourites")!, title: "My Favourites"),
        .init(image: UIImage(named: "Shipping Address")!, title: "Shipping Address"),
        .init(image: UIImage(named: "My Card")!, title: "My Card"),
        .init(image: UIImage(named: "Settings")!, title: "Settings")
    ]
    
    var HelpCenterTable : [ProfileTableViewCellModel] = [
        .init(image: UIImage(named: "FAQs")!, title: "FAQs"),
        .init(image: UIImage(named: "Privacy Policy")!, title: "Privacy Policy"),
        .init(image: UIImage(named: "Community")!, title: "Community"),
    ]
}
