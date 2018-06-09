//
//  History+CoreDataProperties.swift
//  Swap App
//
//  Created by Yaroslav Brekhunchenko on 6/9/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var brand_name: String?
    @NSManaged public var input: Int32
    @NSManaged public var output: Int32
    @NSManaged public var time: Int32

}
