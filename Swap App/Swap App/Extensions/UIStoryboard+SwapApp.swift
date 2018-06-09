//
//  UIStoryboard+SwapApp.swift
//  Swap App
//
//  Created by Anton Klysa on 6/8/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    class func viewControllerWith(identifier: String) -> UIViewController {
        let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        return main.instantiateViewController(withIdentifier:identifier)
    }
}
