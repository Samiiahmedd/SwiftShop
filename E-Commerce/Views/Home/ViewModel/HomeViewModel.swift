//
//  HomeViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 04/09/2024.
//

import Foundation
import UIKit

class HomeViewModel {
    
    //MARK: - Variables
    
    var banners : [BannerModel] = [
        .init(image: UIImage(named: "Banner")!),
        .init(image: UIImage(named: "Banner")!),
        .init(image: UIImage(named: "Banner")!),
        .init(image: UIImage(named: "Banner")!),
    ]
    
    var newArrivals : [NewArrivalModel] = [
        
        .init(productImage: UIImage(named: "Arrival")!,
              productTitle: "The Marc Jacobs",
              productType: "Traveler Tote",
              productPrice: "$200.00"),
        
        .init(productImage: UIImage(named: "Arrival")!,
              productTitle: "The Marc Jacobs",
              productType: "Traveler Tote",
              productPrice: "$195.00"),
        
        .init(productImage: UIImage(named: "Arrival")!,
              productTitle: "The Marc Jacobs",
              productType: "Traveler Tote",
              productPrice: "$195.00"),      
        
            .init(productImage: UIImage(named: "Arrival")!,
              productTitle: "The Marc Jacobs",
              productType: "Traveler Tote",
              productPrice: "$195.00"),
        
        .init(productImage: UIImage(named: "Arrival")!,
              productTitle: "The Marc Jacobs",
              productType: "Traveler Tote",
              productPrice: "$195.00"),
    ]
}
