//
//  UserModel.swift
//  Swap App
//
//  Created by Anton Klysa on 6/7/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation
import Mantle

class UserModel: MTLModel, MTLJSONSerializing {
    
    @objc var city: String?
    @objc var message: String?
    @objc var name: String?
    @objc var team: String?
    
    var host_id: String?
    
    static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return [
            "city": "city",
            "message": "message",
            "name": "name",
            "team": "team"]
    }
    
}
