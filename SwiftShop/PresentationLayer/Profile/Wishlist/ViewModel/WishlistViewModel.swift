//
//  WishlistViewModel.swift
//  E-Commerce
//
//  Created by Sami Ahmed on 02/10/2024.
//

import Foundation
import UIKit
import CoreData

class WishlistViewModel {
    @Published var favouriteProduct: [WishlistProduct] = []
    
    // MARK: - FUNCTIONS
    
    func fetchFavouriteArticles() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<WishlistProduct> = WishlistProduct.fetchRequest()
        
        do {
            favouriteProduct = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch articles: \(error.localizedDescription)")
        }
    }}
