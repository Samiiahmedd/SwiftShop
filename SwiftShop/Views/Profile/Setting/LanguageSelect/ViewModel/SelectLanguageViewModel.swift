//
//  SelectLanguageViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 09/10/2024.
//

import Foundation
import UIKit

class SelectLanguageViewModel{
    var languages : [ProfileTableViewCellModel] = [
        .init(image: UIImage(named: "img")!, title: "English"),
        .init(image: UIImage(named: "img-2")!, title: "Britannica"),
        .init(image: UIImage(named: "img-3")!, title: "Bengali"),
        .init(image: UIImage(named: "img-4")!, title: "German"),
        .init(image: UIImage(named: "img-5")!, title: "Portugese"),
    ]
}
