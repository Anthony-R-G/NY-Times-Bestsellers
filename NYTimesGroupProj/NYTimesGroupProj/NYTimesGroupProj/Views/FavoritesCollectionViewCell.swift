//
//  FavoritesCollectionViewCell.swift
//  NYTimesGroupProj
//
//  Created by Jocelyn Boyd on 10/21/19.
//  Copyright © 2019 Kimball Yang. All rights reserved.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    lazy var outerView: UIView = {
        let outerView = UIView(frame: CGRect(x: 5, y: 25, width: 145, height: 200))
        outerView.clipsToBounds = false
        outerView.layer.shadowColor = UIColor.black.cgColor
        outerView.layer.shadowOpacity = 0.7
        outerView.layer.shadowOffset = CGSize.zero
        outerView.layer.shadowRadius = 7
        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 10).cgPath
        outerView.translatesAutoresizingMaskIntoConstraints = false
    
        return outerView
    }()
    
    lazy var optionsButton: UIButton = {
        let button = UIButton()
        button.showsTouchWhenHighlighted = true
        button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let image = UIImage(systemName: "ellipsis.circle")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(optionsButtonPressed), for: .touchUpInside)
        self.addSubview(button)
        return button
    }()
    
    lazy var bookImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
       
        return imageView
        
    }()
    
    lazy var summaryTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textAlignment = .center
        textView.textColor = #colorLiteral(red: 0.2914385796, green: 0.1974040866, blue: 0.4500601888, alpha: 1)
        textView.layer.cornerRadius = 10
        self.addSubview(textView)
        textView.isUserInteractionEnabled = false
        return textView
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.font = UIFont.italicSystemFont(ofSize: 15)
        self.addSubview(label)
        return label
    }()
    
    lazy var bookTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0.7970843911, green: 1, blue: 0.5273691416, alpha: 1)
        label.font = UIFont(name: "Helvetica-Neue", size: 22)
        self.addSubview(label)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    var buttonFunction: (()->())?
    
    @objc private func optionsButtonPressed() {
        if let closure = buttonFunction {
            closure()
        }
    }
    
    private func setConstraints() {
        setBookImageConstraints()
        setSummaryTextViewConstraints()
        setTitleLabelConstraints()
        setAuthorLabelConstraints()
        setOptionsButtonConstraints()
        setDateLabelConstraints()
    }
    
    private func setOptionsButtonConstraints() {
        optionsButton.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        optionsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optionsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            optionsButton.heightAnchor.constraint(equalToConstant: 30),
            optionsButton.widthAnchor.constraint(equalToConstant: 70),
            optionsButton.topAnchor.constraint(equalTo: topAnchor, constant: 30)
            
        ])
    }
    
    private func setBookImageConstraints() {
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bookImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            bookImage.widthAnchor.constraint(equalToConstant: 120),
            bookImage.heightAnchor.constraint(equalToConstant: 190)
        ])
    }
    
    private func setSummaryTextViewConstraints(){
        summaryTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            summaryTextView.centerXAnchor.constraint(equalTo: centerXAnchor),
            summaryTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
            summaryTextView.widthAnchor.constraint(equalTo: widthAnchor),
            summaryTextView.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    private func setAuthorLabelConstraints() {
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorLabel.leadingAnchor.constraint(equalTo: bookTitleLabel.leadingAnchor),
            authorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 70),
            authorLabel.widthAnchor.constraint(equalTo: bookTitleLabel.widthAnchor),
            authorLabel.heightAnchor.constraint(equalTo: bookTitleLabel.heightAnchor)
        ])
    }
    
    private func setDateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: -18),
            dateLabel.widthAnchor.constraint(equalTo: widthAnchor),
            dateLabel.heightAnchor.constraint(equalTo: bookTitleLabel.heightAnchor)
        
        ])
    }
    
    
    private func setTitleLabelConstraints() {
        bookTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookTitleLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 20),
            bookTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            bookTitleLabel.widthAnchor.constraint(equalToConstant: 280),
            bookTitleLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    public func configureCell(from book: FavoritedBook) {
        backgroundColor =  #colorLiteral(red: 0.2914385796, green: 0.1974040866, blue: 0.4500601888, alpha: 1)
        bookTitleLabel.text = book.title
        authorLabel.text = book.author
        summaryTextView.text = book.description
        dateLabel.text = "Favorited: \(book.date)"
        
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
        self.layer.cornerRadius = 10
        backgroundColor = .white
        addSubview(outerView)
              addSubview(bookImage)
        setConstraints()
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
