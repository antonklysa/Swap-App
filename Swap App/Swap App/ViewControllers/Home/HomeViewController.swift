//
//  HomeViewController.swift
//  Swap App
//
//  Created by Anton Klysa on 6/8/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class HomeViewController: BaseViewController {
    
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //autosync
        MBProgressHUD.showAdded(to: view, animated: true)
        NetworkManager.sharedInstance.swapWith(success: { [weak self] (brands) in
            MBProgressHUD.hide(for: (self?.view)!, animated: true)
            UIApplication.shared.endIgnoringInteractionEvents()
        }) { [weak self] (error) in
            MBProgressHUD.hide(for: (self?.view)!, animated: true)
            UIAlertController.showCustomAlertFor(error: error!)
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    //MARK: actions
    
    @IBAction private func startButtonAction(sender: UIButton) {
        navigationController?.pushViewController(UIStoryboard.viewControllerWith(identifier: SelectBrandsViewController.nameOfClass), animated: true)
    }
    
    @IBAction private func settingsButtonAction(sender: UIButton) {
        navigationController?.pushViewController(UIStoryboard.viewControllerWith(identifier: SettingsViewController.nameOfClass), animated: true)
    }
}
