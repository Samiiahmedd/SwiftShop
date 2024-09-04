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
    
    var popular : [PopularModel]  = [
        .init(popularImage: UIImage(named: "popular")!,
              popularTitle: "Gia Borghini",
              popularDescription: "RHW Rosie 1 Sandals",
              popularRating: "(4.5)",
              popularPrice: "$740.00"),
        
        .init(popularImage: UIImage(named: "popular")!,
              popularTitle: "Gia Borghini",
              popularDescription: "RHW Rosie 1 Sandals",
              popularRating: "(4.5)",
              popularPrice: "$722.00"),
        
        .init(popularImage: UIImage(named: "popular")!,
              popularTitle: "Gia Borghini",
              popularDescription: "RHW Rosie 1 Sandals",
              popularRating: "(4)",
              popularPrice: "$900.00"),
    ]
}
