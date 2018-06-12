//
//  BrandTableViewCell.swift
//  Swap App
//
//  Created by Yaroslav Brekhunchenko on 6/10/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import UIKit

class BrandTableViewCell: UITableViewCell {

    @IBOutlet weak var brandLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.brandLabel.font = UIFont.init(name: "29LTBukra-Regular", size: self.brandLabel.font.pointSize)
    }
    
}
