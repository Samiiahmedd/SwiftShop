//
//  SearchCategoriesViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 05/09/2024.
//

import Foundation
import UIKit

class SearchCategoriesViewModel{
    
    //MARK: - Variables
    
    var categories : [SearchCategoriesModel] = [
        .init(categoryImage: UIImage(named: "first")!,
              categoryTitle: "New Arrivals",
              categoryCount: "208 Product"),
        
        .init(categoryImage: UIImage(named: "second")!,
              categoryTitle: "Clothes",
              categoryCount: "208 Product"),
        
        .init(categoryImage: UIImage(named: "third")!,
              categoryTitle: "Bags",
              categoryCount: "208 Product"),
        
        .init(categoryImage: UIImage(named: "fourth")!,
              categoryTitle: "Shoses",
              categoryCount: "290 Product"), 
        
            .init(categoryImage: UIImage(named: "fifth")!,
              categoryTitle: "Electronics",
              categoryCount: "190 Product"),  
        
            .init(categoryImage: UIImage(named: "fifth")!,
              categoryTitle: "Jewelry",
              categoryCount: "353 Product"),
    ]

}
