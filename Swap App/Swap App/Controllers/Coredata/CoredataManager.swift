//
//  CoredataManager.swift
//  Swap App
//
//  Created by Anton Klysa on 6/7/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoredataManager: NSObject {
    
    static let sharedInstance: CoredataManager = CoredataManager()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let persistentStoreCoordinator = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.persistentStoreCoordinator
    
    private enum CoredataObjectType: String {
        case history = "History"
        case brand = "Brand"
    }
    
    
    //MARK: operations with Brands objects
    
    final func createBrands(source: [[String: Any]]) -> [Brand] {
        
        var brands: [Brand] = []
        
        for item  in source {
            let entity = NSEntityDescription.entity(forEntityName: CoredataObjectType.brand.rawValue, in: context)
            let brand: Brand = NSManagedObject(entity: entity!, insertInto: context) as! Brand

            brand.id = Int32(item["id"] as! String)!
            brand.name = item["name"] as? String
            brand.pack_price = Double(item["pack_price"] as! String)!
            brand.stick_price = Double(item["stick_price"] as! String)!
            
            brands.append(brand)
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        return brands
    }
    
    final func getBrands() -> [Brand]? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoredataObjectType.brand.rawValue)
        request.returnsObjectsAsFaults = false
        do {
            let result: [Brand] = try context.fetch(request) as! [Brand]
            return result
        } catch {
            print("Failed")
        }
        
        return nil
    }
    
    final func deleteBrands() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoredataObjectType.brand.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentStoreCoordinator.execute(deleteRequest, with: context)
        } catch {
            print("Failed")
        }
    }
    
    //MARK: operations with Histories objects
    
    final func createHistory(source: [String: Any]) -> History {
        
        let entity = NSEntityDescription.entity(forEntityName: CoredataObjectType.history.rawValue, in: context)
        let history: History = NSManagedObject(entity: entity!, insertInto: context) as! History
        
        history.input = Int32(source["input"] as! Int)
        history.brand_name = source["brand_name"] as? String
        history.output = Int32(source["output"] as! Int)
        history.time = Int32(source["time"] as! Int)
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        return history
    }
    
    final func getHistories() -> [History]? {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoredataObjectType.history.rawValue)
        request.returnsObjectsAsFaults = false
        do {
            let result: [History] = try context.fetch(request) as! [History]
            return result
        } catch {
            print("Failed")
        }
        
        return nil
    }
    
    final func deleteHistories() {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoredataObjectType.history.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try persistentStoreCoordinator.execute(deleteRequest, with: context)
        } catch {
            print("Failed")
        }
    }
    
    
    //MARK: parser
    
    class func parseToJSONArray(source: [NSManagedObject]) -> [[String: Any]] {
        
        var parsedArray: [[String: Any]]  = []
        
        for item in source {
            let keys = Array(item.entity.attributesByName.keys)
            let dict = item.dictionaryWithValues(forKeys: keys)
            
            parsedArray.append(dict)
        }
        
        return parsedArray
    }
}
