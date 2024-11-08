//
//  SettingViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 09/10/2024.
//

import Foundation
import UIKit

class SettingViewModel{
    var genders : [GenderModel] = [.init(gender: "Male"),.init(gender: "Female")]
    
    var settings : [ProfileTableViewCellModel] =
    [.init(image: UIImage(named: "Language")!, title: "Language"),
    .init(image: UIImage(named: "Notifications")!, title: "Notifications"),
    .init(image: UIImage(named: "Mode")!, title: "Dark Mode"),
    .init(image: UIImage(named: "Help")!, title: "Help Center"),
    ]
}
