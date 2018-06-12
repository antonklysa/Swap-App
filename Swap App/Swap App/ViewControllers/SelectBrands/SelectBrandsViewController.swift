//
//  SelectBrandsViewController.swift
//  Swap App
//
//  Created by Anton Klysa on 6/8/18.
//  Copyright © 2018 Anton Klysa. All rights reserved.
//

import Foundation
import UIKit
import ActionSheetPicker_3_0

class SelectBrandsViewController: BaseViewController, UITextFieldDelegate{
    
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var brandsTableView: UITableView!
    
    private var brands: [String] = []
    private var selectedIndex: Int! = 0
    
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.brandTextField.font = UIFont.init(name: "29LTBukra-Regular", size: 27.0)
        self.countTextField.font = UIFont.init(name: "29LTBukra-Regular", size: 27.0)
        
        //arabic texfields
//        brandTextField.semanticContentAttribute = .forceRightToLeft
//        countTextField.semanticContentAttribute = .forceRightToLeft
        brandTextField.textAlignment = .right
        countTextField.textAlignment = .center
        self.brandTextField.placeholder = String("ﺍﻟﻤﺎﺭﻛﺔ".reversed())
        
        for item in CoredataManager.sharedInstance.getBrands()! {
             brands.append(item.name!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //clear data
        brandTextField.text = nil
        countTextField.text = nil
        selectedIndex = nil
    }
    
    
    //MARK: actions
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func calculateButtonAction(sender: UIButton) {
        
        view.endEditing(true)
        
        if countTextField.text!.isEmpty {
            UIAlertController.showCustomErrorAlertWith(message: "Veuillez renseigner la quantité")
            return
        }
        
        if brandTextField.text!.isEmpty {
            UIAlertController.showCustomErrorAlertWith(message: "Veuillez selectionner une marque")
            return
        }
        
        if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: countTextField.text!)) {
            UIAlertController.showCustomErrorAlertWith(message: "Le nombre renseigné est incorrect")
            return
        }
        
        let selectedBrand: Brand = CoredataManager.sharedInstance.getBrands()![selectedIndex]
        
        if Int(Double(countTextField.text!)!) == 0 {
            UIAlertController.showCustomErrorAlertWith(message: "Veuillez entrer un nombre")
            return
        }
        
        let chesterfieldStickPrice: Double = CoredataManager.sharedInstance.chesterfieldStickPrice
        let outputValue = Int((Double(countTextField.text!)! * selectedBrand.stick_price)/chesterfieldStickPrice)
        if outputValue == 0 {
            UIAlertController.showCustomErrorAlertWith(message: "Entrez une quantité minimum de 2 pour cette marque")
            return
        }
        if Double(countTextField.text!)! > 500.0 {
            UIAlertController.showCustomErrorAlertWith(message: "Veuillez entrer un nombre inférieur à 500")
            return
        }
        let historyDict: [String: Any] = ["input": NSNumber(value: Int(countTextField.text!)!),
                                    "output": NSNumber(value: outputValue),
                                    "brand_name": selectedBrand.name!,
                                    "time": NSNumber.init(value: Int(NSDate().timeIntervalSince1970))]
        
        let history: History = CoredataManager.sharedInstance.createHistory(source: historyDict)
        
        let calBrandsVC: CalculateBrandsViewController = UIStoryboard.viewControllerWith(identifier: CalculateBrandsViewController.nameOfClass) as! CalculateBrandsViewController
        calBrandsVC.history = history
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(calBrandsVC, animated: false)
    }
    
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.brandsTableView.isHidden = !self.brandsTableView.isHidden
        
        return false
    }
}

extension SelectBrandsViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BrandTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: BrandTableViewCell.self)) as! BrandTableViewCell
        let brand: Brand = CoredataManager.sharedInstance.getBrands()![indexPath.row]
        cell.brandLabel.text = brand.name
        if (indexPath.row == self.selectedIndex) {
            cell.backgroundColor = UIColor(red: 215.0/255.0, green: 24.0/255.0, blue: 42.0/255.0, alpha: 1.0)
            cell.brandLabel.textColor = UIColor.white
        } else {
            cell.backgroundColor = UIColor.white
            cell.brandLabel.textColor = UIColor.black
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoredataManager.sharedInstance.getBrands()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let brand: Brand = CoredataManager.sharedInstance.getBrands()![indexPath.row]
        self.brandTextField.text = brand.name
        self.selectedIndex = indexPath.row
        self.brandsTableView.isHidden = true
        
        tableView.reloadData()
    }
}
