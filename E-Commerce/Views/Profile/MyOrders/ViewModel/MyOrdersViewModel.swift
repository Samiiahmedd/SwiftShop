//
//  MyOrdersViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 10/10/2024.
//

import Foundation
import UIKit

class MyOrdersViewModel{
    var MyOrders : [MyOrdersModel] = [
        .init(productImage: UIImage(named: "productImage2")!,
              productName: "Axel Arigato",
              productDescription: "Vado Odelle Dress",
              productQuality: 1,
              productSize: "L",
              productColor: .red),
        
        .init(productImage: UIImage(named: "productImage2")!,
              productName: "Nike Shoes",
              productDescription: "Jordan",
              productQuality: 1,
              productSize: "41",
              productColor: .green),
        
            .init(productImage: UIImage(named: "productImage1")!,
              productName: "Addidas",
              productDescription: "Daypack Backpack",
              productQuality: 1,
              productSize: "44",
              productColor: .black),
    ]
    
}
