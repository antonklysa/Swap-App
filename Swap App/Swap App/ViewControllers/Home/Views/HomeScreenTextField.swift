//
//  HomeScreenTextField.swift
//  Swap App
//
//  Created by Yaroslav Brekhunchenko on 6/9/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import UIKit

class HomeScreenTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 52, bottom: 0, right: 8);
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
}
