//
//  SettingsViewController.swift
//  Swap App
//
//  Created by Anton Klysa on 6/8/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class SettingsViewController: BaseViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var villeLabel: UILabel!
    @IBOutlet weak var derniereSyncLabel: UILabel!
    
    
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setup controller props
        
        contentView.layer.cornerRadius = 5
        contentView.alpha = 0.78
        
        hostLabel.text = "Host ID : \((UserManager.sharedInstance.currentUser?.host_id)!)"
        nomLabel.text = "Nom : \((UserManager.sharedInstance.currentUser?.name)!)"
        villeLabel.text = "Ville : \((UserManager.sharedInstance.currentUser?.city)!)"
        derniereSyncLabel.text = "Derniere synchronisation : \((UserManager.sharedInstance.currentUser?.syncDate)!)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.topLogoImage.isHidden = true
    }
    
    
    //MARK: actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func disconnectButtonAction(sender: UIButton) {
        //TODO: implement disconnect function
    }
    
    @IBAction func syncButtonAction(sender: UIButton) {
    
        MBProgressHUD.showAdded(to: view, animated: true)
        NetworkManager.sharedInstance.swapWith(success: { [weak self] (brands) in
            MBProgressHUD.hide(for: (self?.view)!, animated: true)
            UIAlertController.showCustomSuccessAlert()
        }) { [weak self] (error) in
            MBProgressHUD.hide(for: (self?.view)!, animated: true)
            UIAlertController.showCustomAlertFor(error: error!)
        }
    }
}
