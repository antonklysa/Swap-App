//
//  ViewController.swift
//  Swap App
//
//  Created by Anton Klysa on 6/7/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NetworkManager.sharedInstance.loginWith(name: "SWP000", password: "test", success: { (user) in
            
            print(user)
            
            CoredataManager.sharedInstance.createHistory(source: ["input":2,
                                                                  "output":1,
                                                                  "brand_name":"Brand 1",
                                                                  "time":"1510745504"])
            
            NetworkManager.sharedInstance.swapWith(success: { (brands) in
                print(brands)
                
                print(CoredataManager.sharedInstance.getBrands())
                
            }, failure: { (error) in
                print(error)
            })
            
        }) { (error) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

