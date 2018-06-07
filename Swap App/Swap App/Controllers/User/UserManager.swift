//
//  UserManager.swift
//  Swap App
//
//  Created by Anton Klysa on 6/7/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation

class UserManager: NSObject {
    
    static let sharedInstance: UserManager = UserManager()
    
    var currentUser: UserModel?
}
