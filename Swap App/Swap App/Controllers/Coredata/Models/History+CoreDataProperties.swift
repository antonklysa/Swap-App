//
//  History+CoreDataProperties.swift
//  
//
//  Created by Anton Klysa on 6/7/18.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var input: Int32
    @NSManaged public var output: Int32
    @NSManaged public var brand_name: String?
    @NSManaged public var time: Int32

}
