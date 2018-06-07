//
//  Brand+CoreDataProperties.swift
//  
//
//  Created by Anton Klysa on 6/7/18.
//
//

import Foundation
import CoreData


extension Brand {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Brand> {
        return NSFetchRequest<Brand>(entityName: "Brand")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var pack_price: Double
    @NSManaged public var strick_price: Double

}
