//
//  FilterViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 22/09/2024.
//

import Foundation

class FilterViewModel {
    
    //MARK: - Variables
    var categories : [FilterCategoriesModel] = [.init(categoryName: "Dresses"),
                                          .init(categoryName: "Jackets"),
                                          .init(categoryName: "Jeans"),
                                          .init(categoryName: "Shoses"),
                                          .init(categoryName: "Bags"),
                                          .init(categoryName: "Clothes"),
                                          .init(categoryName: "Jeans"),
                                          .init(categoryName: "Shorts"),
                                          .init(categoryName: "Tops"),
                                          .init(categoryName: "Sneakers"),
                                          .init(categoryName: "Coats"),
                                          .init(categoryName: "Lingenies")]
    
    var sortBy : [SortByModel] = [.init(name: "New Today"),
                                  .init(name: "New This Week"),
                                  .init(name: "Top Seller")]
    
}
