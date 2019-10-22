//
//  FavoritesViewController.swift
//  NYTimesGroupProj
//
//  Created by Kimball Yang on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    //MARK: -- Properties
    lazy var favsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = #colorLiteral(red: 0.03647105396, green: 0.130553931, blue: 0.1811579168, alpha: 1)
        collectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: "favoritesCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        let imageView = UIImageView(image: #imageLiteral(resourceName: "bg"))
//        collectionView.backgroundView = imageView
        
        self.view.addSubview(collectionView)
        return collectionView
    }()
    
    var favoriteBooks = [FavoritedBook]() {
        didSet {
            favsCollectionView.reloadData()
        }
    }
    
    
    private func loadFavsData() {
        try! favoriteBooks = FavoriteBookPersistenceHelper.manager.getBooks()
    }
    
    private func setCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            favsCollectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            favsCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favsCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            favsCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    private func presentActionSheet(id: Int, book: FavoritedBook) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.deleteBook(with: id) }
        
        let amazonAction = UIAlertAction(title: "See on Amazon", style: .default) { (action) in
            self.redirectToAmazonPage(currentBook: book)
        }
        
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(amazonAction)
        actionSheet.addAction(deleteAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    private func deleteBook(with id: Int) {
        do {
            try FavoriteBookPersistenceHelper.manager.deleteBook(specificID: id)
        } catch {}
        
        do {
            self.favoriteBooks = try FavoriteBookPersistenceHelper.manager.getBooks()
        } catch {}
    }
    
    private func redirectToAmazonPage(currentBook: FavoritedBook) {
        if let url = URL(string: currentBook.amazon_product_url) {
            UIApplication.shared.open(url)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavsData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewConstraints()
    }
    
}

//MARK: -- Extensions
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favsCell = favsCollectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath) as! FavoritesCollectionViewCell
        let specificFavorite = favoriteBooks[indexPath.row]
        favsCell.configureCell(from: specificFavorite)
        favsCell.buttonFunction = { self.presentActionSheet(id: specificFavorite.id, book: specificFavorite) }
        
        return favsCell
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 325)
    }
}



