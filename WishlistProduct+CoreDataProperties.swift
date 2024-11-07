//
//  WishlistProduct+CoreDataProperties.swift
//  SwiftShop
//
//  Created by Sami Ahmed on 07/11/2024.
//
//

import Foundation
import CoreData


extension WishlistProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishlistProduct> {
        return NSFetchRequest<WishlistProduct>(entityName: "WishlistProduct")
    }

    @NSManaged public var title: String?
    @NSManaged public var price: Double
    @NSManaged public var category: String?
    @NSManaged public var desc: String?
    @NSManaged public var id: Int32
    @NSManaged public var image: String?

}

extension WishlistProduct : Identifiable {

}
