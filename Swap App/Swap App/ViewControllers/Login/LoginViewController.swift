//
//  LoginViewController.swift
//  Swap App
//
//  Created by Anton Klysa on 6/8/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import TPKeyboardAvoiding

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLogoImage.isHidden = true
    }
    
    
    //MARK: actions
    
    @IBAction private func connectButtonAction(sender: UIButton) {
        
        if nameTextField.text != nil && passwordTextField.text != nil {
            MBProgressHUD.showAdded(to: self.view, animated: true)
            NetworkManager.sharedInstance.loginWith(name: nameTextField.text, password: passwordTextField.text, success: { [weak self] (user) in
                MBProgressHUD.hide(for: (self?.view)!, animated: true)
                
                //set sync date
                let formatter: DateFormatter = DateFormatter()
                formatter.dateFormat = "YYYY/MM/dd hh:mm"
                user?.syncDate = formatter.string(from: Date())
                
                //save current user
                let archivedObject = NSKeyedArchiver.archivedData(withRootObject: user)
                UserDefaults.standard.set(archivedObject, forKey: "kCurrentUser")
                UserDefaults.standard.synchronize()
                
                self?.navigationController?.pushViewController(UIStoryboard.viewControllerWith(identifier: HomeViewController.nameOfClass), animated: true)
                
            }) { [weak self] (error) in
                MBProgressHUD.hide(for: (self?.view)!, animated: true)
                UIAlertController.showCustomAlertFor(error: error!)
            }
        }
    }
        
        
    
}
