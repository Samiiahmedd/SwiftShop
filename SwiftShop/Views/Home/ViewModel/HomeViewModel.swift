//
//  HomeViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 04/09/2024.
//

import Foundation
import UIKit

class HomeViewModel {
    
    /// input

    /*
     view all
     nav bar buttons
     banner click action
     arrival cell clickd
     popular as will as
     */
    
    /// output
    /*
     banners
     new arrival
     populars
     loading
     error
     */
    
    var banners : [BannerModel] = [
        .init(image: UIImage(named: "Banner")!),
        .init(image: UIImage(named: "Banner")!),
        .init(image: UIImage(named: "Banner")!),
        .init(image: UIImage(named: "Banner")!),
    ]
    
    //NewArrival
    @MainActor
    func getNewArrivals(completion:@escaping (Result <NewArrivalsModel, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/products/first5") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(NewArrivalsModel.self, from: data)
                print(data)
                completion(.success(results))
            }catch{
                print("Error")
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    
    
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
        
            .init(popularImage: UIImage(named: "popular")!,
              popularTitle: "Gia Borghini",
              popularDescription: "RHW Rosie 1 Sandals",
              popularRating: "(4)",
              popularPrice: "$900.00"),
        
        .init(popularImage: UIImage(named: "popular")!,
              popularTitle: "Gia Borghini",
              popularDescription: "RHW Rosie 1 Sandals",
              popularRating: "(4)",
              popularPrice: "$900.00"),
        
        .init(popularImage: UIImage(named: "popular")!,
              popularTitle: "Gia Borghini",
              popularDescription: "RHW Rosie 1 Sandals",
              popularRating: "(4)",
              popularPrice: "$900.00"),
    ]
}
