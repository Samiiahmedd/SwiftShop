//
//  PaymentMethodViewModel.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 14/10/2024.
//

import Foundation
import UIKit

class PaymentMethodViewModel{
    
    var paymentMethod : [ProfileTableViewCellModel] = [
        .init(image:UIImage(named: "atm")!, title: "Online"),
        .init(image:UIImage(named: "cash")!, title: "Cash"),
    ]
    
    var coordinator: HomeCoordinatorProtocol
    
    init(coordinator: HomeCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
