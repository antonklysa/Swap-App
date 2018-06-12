//
//  CalculateBrandsViewController.swift
//  Swap App
//
//  Created by Anton Klysa on 6/8/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation
import UIKit

class CalculateBrandsViewController: BaseViewController {
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var outputLabel: UILabel!
    
    var history: History!
    
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputLabel.font = UIFont.init(name: "29LTBukra-Regular", size: 30.0)
        inputLabel.text = "\(history.input)" + " " + "\(history.brand_name!)"
        outputLabel.font = UIFont.init(name: "29LTBukra-Bold", size: 37.0)
        outputLabel.text = "ﺪﻠﻴﻓﺮﺘﺴﻴﺷ" + " " + "\(history.output)"
    }
    
    
    //MARK: actions
    
    @IBAction private func endButtonAction(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
