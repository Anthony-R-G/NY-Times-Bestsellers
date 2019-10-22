//
//  DetailViewController.swift
//  NYTimesGroupProj
//
//  Created by Anthony Gonzalez on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var outerView: UIView = {
        let outerView = UIView(frame: CGRect(x: 40, y: 203, width: 330, height: 475))
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 0.7
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 7
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 10).cgPath
        outerView.translatesAutoresizingMaskIntoConstraints = false
        return outerView
    }()
    
    lazy var bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var weeksLabel: UILabel = {
          let label = UILabel()
          label.textAlignment = .center
          label.adjustsFontSizeToFitWidth = true
          label.textColor = #colorLiteral(red: 0.8743566871, green: 0.8691595197, blue: 0.8783521056, alpha: 1)
          label.font = UIFont.systemFont(ofSize: 17)
          label.adjustsFontSizeToFitWidth = true
          label.translatesAutoresizingMaskIntoConstraints = false
          view.addSubview(label)
          return label
      }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.7970843911, green: 1, blue: 0.5273691416, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var bookTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.textColor = . white
        textView.font = UIFont.systemFont(ofSize: 19)
        textView.isEditable = false
        textView.textAlignment = .center
        view.addSubview(textView)
        
        return textView
    }()
    
    lazy var amazonButton: UIButton = {
        let button = UIButton()
        var frame = button.frame
        frame.size.width = 50
        frame.size.height = 50
        button.frame = frame
        button.layer.cornerRadius = button.frame.width/2
        button.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.layer.borderWidth = 1.0
        button.contentMode = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "amazon-icon"), for: .normal)
        button.addTarget(self, action: #selector(amazonButtonPressed), for: .touchUpInside)
        view.addSubview(button)
        
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(favoritesButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        view.addSubview(button)
        return button
    }()
    
    lazy var pomeButton: UIButton = {
        let button = UIButton()
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(pomeButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "pomegranate")
        button.setImage(image, for: .normal)
        view.addSubview(button)
        return button
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        view.addSubview(button)
        return button
    }()
    
    lazy var placeHolderImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "NYTicon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        return imageView
    }()
    
    var currentBook: NYTimeBook!
    
    @objc private func favoritesButtonPressed(){
        let favoritedBook = FavoritedBook(weeks_on_list: currentBook.weeks_on_list, description: currentBook.description, title: currentBook.title, author: currentBook.author, book_image: currentBook.book_image, amazon_product_url: currentBook.amazon_product_url, date: FavoritedBook.getTimeStamp(), id: FavoritedBook.getIDForNewBook())
        
        do {
            try? FavoriteBookPersistenceHelper.manager.save(newBook: favoritedBook)
        }
        presentAlert()
    }
    
    @objc private func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func pomeButtonPressed(){
        let nextVC = FavoritesViewController()
        let davidBook = FavoritedBook(weeks_on_list: 100, description: "Writing code with the one and only David. Easy and fast to learn, Cool Swift code. No refunds.", title: "Isn't this COOL?", author: "David Rifkin", book_image: "https://i.imgur.com/emnseIU.png", amazon_product_url: "not avaiable", date: "June 24", id: 6)
        do{
            try? FavoriteBookPersistenceHelper.manager.save(newBook: davidBook)
        }
        present(nextVC, animated: true, completion:  nil)
    }
    
    @objc private func amazonButtonPressed() {
        if let url = URL(string: currentBook.amazon_product_url) {
            UIApplication.shared.open(url)
        }
    }
    
    private func presentAlert(){
        let alertVC = UIAlertController(title: nil, message: "Added \(currentBook.title) to favorites!", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func setButtonConstraints() {
        NSLayoutConstraint.activate([
            amazonButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amazonButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            amazonButton.heightAnchor.constraint(equalToConstant: 50),
            amazonButton.widthAnchor.constraint(equalToConstant: 50),
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 150),
            saveButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            saveButton.heightAnchor.constraint(equalToConstant: 30),
            saveButton.widthAnchor.constraint(equalToConstant: 60),
            
            pomeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -150),
            pomeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            pomeButton.heightAnchor.constraint(equalToConstant: 60),
            pomeButton.widthAnchor.constraint(equalToConstant: 60),
            
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -150),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: bookImage.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 70),
            
            authorLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            authorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 275),
            authorLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            authorLabel.heightAnchor.constraint(equalToConstant: 70),
            
            weeksLabel.centerXAnchor.constraint(equalTo: bookImage.centerXAnchor),
            weeksLabel.topAnchor.constraint(equalTo: bookImage.topAnchor, constant: -70),
            weeksLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            weeksLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func setTextViewConstraints() {
        NSLayoutConstraint.activate([
            bookTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookTextView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 360),
            bookTextView.heightAnchor.constraint(equalToConstant: 130),
            bookTextView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    
    private func setBookImageConstraints() {
        NSLayoutConstraint.activate([
            bookImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            bookImage.heightAnchor.constraint(equalToConstant: 450),
            bookImage.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func configureUI() {
        view.backgroundColor = #colorLiteral(red: 0.2914385796, green: 0.1974040866, blue: 0.4500601888, alpha: 1)
        bookTextView.text = currentBook.description
        titleLabel.text = currentBook.title
        authorLabel.text = currentBook.author
        weeksLabel.text = "\(currentBook.weeks_on_list) weeks on best seller"
        
        ImageHelper.shared.getImage(urlStr: currentBook.book_image) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let imageFromOnline):
                DispatchQueue.main.async {
                    self.bookImage.image = imageFromOnline
                }
            }
        }
    }
    
    private func setConstraints() {
        setBookImageConstraints()
        setTextViewConstraints()
        setButtonConstraints()
        setLabelConstraints()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(outerView)
        view.addSubview(bookImage)
        setConstraints()
        configureUI()
        
        
    }
}
