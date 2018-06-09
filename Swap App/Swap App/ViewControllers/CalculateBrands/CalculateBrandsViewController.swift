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
        
        inputLabel.text = "\(history.input)"
        outputLabel.text = "\(history.output)"
    }
    
    
    //MARK: actions
    
    @IBAction private func endButtonAction(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
