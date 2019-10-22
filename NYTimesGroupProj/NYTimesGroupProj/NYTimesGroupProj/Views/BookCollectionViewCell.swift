//
//  BookCollectionViewCell.swift
//  NYTimesGroupProj
//
//  Created by Anthony Gonzalez on 10/18/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    lazy var outerView: UIView = {
        let outerView = UIView(frame: CGRect(x: 80, y: 130, width: 255, height: 355))
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
        imageView.layer.cornerRadius = 10
        imageView.image = #imageLiteral(resourceName: "noImage")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true

        return imageView
        
    }()
    
    lazy var summaryTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.backgroundColor = #colorLiteral(red: 0.2914385796, green: 0.1974040866, blue: 0.4500601888, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textView)
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    lazy var weeksLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.7970843911, green: 1, blue: 0.5273691416, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        self.addSubview(label)
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    
    private func setOuterViewConstraints() {
        NSLayoutConstraint.activate([
            outerView.centerXAnchor.constraint(equalTo: bookImage.centerXAnchor, constant: 75),
            outerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 140),
            outerView.widthAnchor.constraint(equalToConstant: 400),
            outerView.heightAnchor.constraint(equalToConstant: 400)
            
        ])
        
    }
    private func setConstraintsForBookImage(){
        NSLayoutConstraint.activate([
            bookImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            bookImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 140),
            bookImage.widthAnchor.constraint(equalToConstant: 235),
            bookImage.heightAnchor.constraint(equalToConstant: 335)
        ])
    }
    
    private func setSummaryTextViewConstraints(){
        NSLayoutConstraint.activate([
            summaryTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            summaryTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
            summaryTextView.widthAnchor.constraint(equalToConstant: 340),
            summaryTextView.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func setWeeksLabelConstraints() {
        NSLayoutConstraint.activate([
            weeksLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            weeksLabel.topAnchor.constraint(equalTo: summaryTextView.topAnchor, constant: -50),
            weeksLabel.widthAnchor.constraint(equalTo: summaryTextView.widthAnchor),
            weeksLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            bookTitleLabel.centerXAnchor.constraint(equalTo: bookImage.centerXAnchor),
            bookTitleLabel.topAnchor.constraint(equalTo: bookImage.topAnchor, constant: -95),
            bookTitleLabel.widthAnchor.constraint(equalToConstant: 340),
            bookTitleLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setAuthorLabelConstraints() {
        NSLayoutConstraint.activate([
            authorLabel.centerXAnchor.constraint(equalTo: bookTitleLabel.centerXAnchor),
            authorLabel.topAnchor.constraint(equalTo: bookTitleLabel.topAnchor, constant: 30),
            authorLabel.widthAnchor.constraint(equalToConstant: 260),
            authorLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    private func setConstraints(){
        setConstraintsForBookImage()
        setSummaryTextViewConstraints()
        setTitleLabelConstraints()
        setAuthorLabelConstraints()

    }
    
    public func configureCell(from book: NYTimeBook) {
        self.layer.cornerRadius = 10
        backgroundColor =  #colorLiteral(red: 0.2914385796, green: 0.1974040866, blue: 0.4500601888, alpha: 1)
        bookTitleLabel.text = book.title
        authorLabel.text = book.author
        
        summaryTextView.text = book.description
        //        weeksLabel.text = "\(book.weeks_on_list) weeks on best seller.."
        
        ImageHelper.shared.getImage(urlStr: book.book_image) { (result) in
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(outerView)
        self.addSubview(bookImage)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
