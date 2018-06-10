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
    
    private var brands: [String] = []
    private var selectedIndex: Int!
    
    //MARK: lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //arabic texfields
        brandTextField.semanticContentAttribute = .forceRightToLeft
        countTextField.semanticContentAttribute = .forceRightToLeft
        brandTextField.textAlignment = .right
        countTextField.textAlignment = .center
        
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
        
        let outputValue = Int(Double(countTextField.text!)! * selectedBrand.stick_price)
        if outputValue == 0 {
            UIAlertController.showCustomErrorAlertWith(message: "Entrez une quantité minimum de 2 pour cette marque")
            return
        }
        let historyDict: [String: Any] = ["input": NSNumber(value: Int(countTextField.text!)!),
                                    "output": NSNumber(value: outputValue),
                                    "brand_name": selectedBrand.name!,
                                    "time": NSNumber.init(value: Int(NSDate().timeIntervalSince1970))]
        
        let history: History = CoredataManager.sharedInstance.createHistory(source: historyDict)
        
        let calBrandsVC: CalculateBrandsViewController = UIStoryboard.viewControllerWith(identifier: CalculateBrandsViewController.nameOfClass) as! CalculateBrandsViewController
        calBrandsVC.history = history
        
        navigationController?.pushViewController(calBrandsVC, animated: true)
    }
    
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == brandTextField {
            var index: Int = 0
            if !(textField.text?.isEmpty)! {
                index = brands.contains(textField.text!) ? brands.index(of: textField.text!)! : 0
            }
            let sheetPicker: ActionSheetStringPicker = ActionSheetStringPicker.init(title: "", rows: brands, initialSelection: index, doneBlock: { [weak self] (picker, valueIndex, value) in
                textField.text = value as? String
                self?.selectedIndex = valueIndex
            }, cancel: { (picker) in
            }, origin: textField)
            
            sheetPicker.show()
            return false
        }
        
        return true
    }
}
