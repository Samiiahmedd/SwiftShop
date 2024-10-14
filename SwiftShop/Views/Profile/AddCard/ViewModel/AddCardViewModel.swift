//
//  AddCardViewModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 14/10/2024.
//

import Foundation
import UIKit

class AddCardViewModel{
    var paymentMethod : [ProfileTableViewCellModel] = [
        .init(image: UIImage(named: "paypal")!, title: "Paypal"),
        .init(image: UIImage(named: "payoneer")!, title: "Payoneer"),
        .init(image: UIImage(named: "visa")!, title: "Visa"),
        .init(image: UIImage(named: "google pay")!, title: "Google pay"),
    ]
}
