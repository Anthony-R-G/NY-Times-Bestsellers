//
//  ViewController.swift
//  NYTimesGroupProj
//
//  Created by Kimball Yang on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit

class bestSellersViewController: UIViewController {
    //MARK: -- Properties
    
    lazy var booksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = #colorLiteral(red: 0.2914385796, green: 0.1974040866, blue: 0.4500601888, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "bookCell")
        view.addSubview(collectionView)
        return collectionView
    }()
    
    lazy var genrePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        return picker
    }()
    
    var books = [NYTimeBook]() {
        didSet {
            booksCollectionView.reloadData()
        }
    }
    
    var categories = [ListNameResult]() {
        didSet {
            genrePicker.reloadAllComponents()
        }
    }
    
    var selectedCategory = String() {
        didSet {
            loadBooksInSelectedCategory()

        }
    }
    
    private func loadCategoriesData() {
        NYTimesCategoriesAPIClient.shared.getCategories { (result) in
            switch result {
            case .success(let categoryData):
                self.categories = categoryData
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func loadBooksInSelectedCategory() {
        NYTimesBookAPIClient.shared.getBooks(categoryName: selectedCategory) { (result) in
            switch result {
            case .success(let booksFromOnline):
                self.books = booksFromOnline
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    //MARK: -- Constraints
    private func setCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            booksCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            booksCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            booksCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            booksCollectionView.heightAnchor.constraint(equalToConstant: 635)
        ])
    }
    
    private func setPickerConstraints() {
        NSLayoutConstraint.activate([
            genrePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genrePicker.widthAnchor.constraint(equalTo: view.widthAnchor),
            genrePicker.heightAnchor.constraint(equalToConstant: 305),
            genrePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setConstraints(){
        setCollectionViewConstraints()
        setPickerConstraints()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadCategoriesData()
        loadUserDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9763752818, green: 0.9765191674, blue: 0.9763557315, alpha: 1)
        setConstraints()
        loadCategoriesData()
        
    }
    
    private func loadUserDefaults(){
        if let rowInteger = UserDefaults.standard.object(forKey: "rowNumber") as? Int, let category = UserDefaults.standard.object(forKey: "categoryName") as? String{
            selectedCategory = category
            genrePicker.selectRow(rowInteger, inComponent: 0, animated: true)
            loadBooksInSelectedCategory()
        } else {
            print("Hi")
        }
    }
    
}

//MARK: -- Extensions
extension bestSellersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if books.count == 0 {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: booksCollectionView.bounds.size.width, height: booksCollectionView.bounds.size.height))
            noDataLabel.text = "Please select a category"
            noDataLabel.textColor = #colorLiteral(red: 0.8060024381, green: 0.801212132, blue: 0.8096852899, alpha: 0.7991491866)
            noDataLabel.font = UIFont.systemFont(ofSize: 20)
            noDataLabel.textAlignment = .center
            booksCollectionView.backgroundView = noDataLabel
        } else {
            booksCollectionView.backgroundView = nil
        }
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bookCell = booksCollectionView.dequeueReusableCell(withReuseIdentifier: "bookCell", for: indexPath) as! BookCollectionViewCell
        let specificBook = books[indexPath.row]
        bookCell.configureCell(from: specificBook)
        return bookCell
    }
}


extension bestSellersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        let currentBook = books[indexPath.row]
        detailVC.currentBook = currentBook
    
        detailVC.modalPresentationStyle = .fullScreen
        detailVC.modalTransitionStyle = .crossDissolve
        present(detailVC, animated: true, completion: nil)
    }
}

extension bestSellersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}

//MARK: -- PickerView DataSource/Delegate
extension bestSellersViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
    }
}

//extension Array {
//  func indexExists(_ index: Int) -> Bool {
//    return self.indices.contains(index)
//  }
//}
