//
//  SettingsViewController.swift
//  NYTimesGroupProj
//
//  Created by Kimball Yang on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit
class SettingsViewController: UIViewController {
    
    lazy var settingGenrePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
  
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        return picker
    }()
    
    private func setPickerConstraints() {
        NSLayoutConstraint.activate([
            settingGenrePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingGenrePicker.widthAnchor.constraint(equalTo: view.widthAnchor),
            settingGenrePicker.heightAnchor.constraint(equalTo: view.heightAnchor),
            settingGenrePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    var categories = [ListNameResult]() {
        didSet {
            settingGenrePicker.reloadAllComponents()
        }
    }
    var selectedCategory = String()
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadUserDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2914385796, green: 0.1974040866, blue: 0.4500601888, alpha: 1)
        setPickerConstraints()
        loadCategoriesData()
    }
    
    
    
    private func loadUserDefaults(){
        if let rowNumbers = UserDefaults.standard.object(forKey: "rowNumber") as? Int {
            settingGenrePicker.selectRow(rowNumbers, inComponent: 0, animated: true)
        } else {
            settingGenrePicker.selectRow(0, inComponent: 0, animated: true)
        }
    }
    
    
    private func loadCategoriesData() {
        NYTimesCategoriesAPIClient.shared.getCategories { (result) in
            switch result {
            case .success(let categoryData):
                self.categories = categoryData
                self.loadUserDefaults()
            case .failure(let error):
                print(error)
            }
        }
    }
    
  
}
extension SettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row].displayName
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row].listNameEncoded
        UserDefaults.standard.set(row, forKey: "rowNumber")
        UserDefaults.standard.set(categories[row].listNameEncoded, forKey: "categoryName")
    }
   
   func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    return NSAttributedString(string: categories[row].displayName, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
}
