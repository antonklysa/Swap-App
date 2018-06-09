//
//  Brand+CoreDataProperties.swift
//  Swap App
//
//  Created by Yaroslav Brekhunchenko on 6/9/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
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
    @NSManaged public var stick_price: Double

}
