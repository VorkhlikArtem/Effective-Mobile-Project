//
//  BestSellersCell.swift
//  Ecommerce Concept
//
//  Created by Артём on 03.12.2022.
//

import UIKit

class BestSellerCell: UICollectionViewCell {
    
    static var reuseId: String = "BestSellerCell"
    
    var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                likeButton.setImage(UIImage(named: "selected"), for: .normal)
            } else {
                likeButton.setImage(UIImage(named: "unselected"), for: .normal)
            }
        }
    }
    
    let bestSellersImageView = WebImageView()
    
    let currentPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "MarkPro-Bold", size: 16)
        label.textColor = .blackTextColor
        return label
    }()
    
    let formerPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "MarkPro-Medium", size: 10)
        label.textColor = .grayTextColor
       
        
        return label
    }()
    
    let modelName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "MarkPro-Regular", size: 10)
        label.textColor = .blackTextColor
        label.numberOfLines = 1
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .white
        button.tintColor = .red
        button.setImage(UIImage(named: "unselected"), for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 4
        clipsToBounds = true
        bestSellersImageView.contentMode = .scaleAspectFit
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        setupConstraints()
    }
    
    override func prepareForReuse() {
        bestSellersImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        likeButton.clipsToBounds = true
        likeButton.layer.cornerRadius = likeButton.frame.height / 2
        
        likeButton.layer.shadowColor = UIColor.black.cgColor
        likeButton.layer.shadowRadius = 2
        likeButton.layer.shadowOpacity = 1
        likeButton.layer.shadowOffset = .init(width: 2, height: 2)
    }
    
    @objc func likeButtonTapped() {
        isFavorite.toggle()
//        if isFavorite {
//            likeButton.setImage(UIImage(named: "selected"), for: .normal)
//        } else {
//            likeButton.setImage(UIImage(named: "unselected"), for: .normal)
//        }
        
    }
    
    func configure(with bestSellerModel: BestSellersItem) {
        bestSellersImageView.set(imageURL: bestSellerModel.picture)
        currentPrice.text = "$\(bestSellerModel.discountPrice)"
        formerPrice.attributedText = NSMutableAttributedString(string: "$\(bestSellerModel.priceWithoutDiscount)", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        modelName.text = bestSellerModel.title
        
        isFavorite = bestSellerModel.isFavorites
    }
    
    func setupConstraints() {
        
      
        
        modelName.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(modelName)
        NSLayoutConstraint.activate([
          
            modelName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            modelName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            modelName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -21),
        ])
        
        currentPrice.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(currentPrice)
        NSLayoutConstraint.activate([
            currentPrice.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 21),
            currentPrice.bottomAnchor.constraint(equalTo: modelName.topAnchor, constant: -5)
        ])
        
        formerPrice.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(formerPrice)
        NSLayoutConstraint.activate([
            formerPrice.leadingAnchor.constraint(equalTo: currentPrice.trailingAnchor, constant: 7),
            formerPrice.bottomAnchor.constraint(equalTo: currentPrice.bottomAnchor, constant: -3)
        ])
        
        bestSellersImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(bestSellersImageView)
        NSLayoutConstraint.activate([
            bestSellersImageView.bottomAnchor.constraint(equalTo: currentPrice.topAnchor, constant: -1),
            bestSellersImageView.topAnchor.constraint(equalTo: topAnchor),
            bestSellersImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.insertSubview(likeButton, aboveSubview: bestSellersImageView)
        NSLayoutConstraint.activate([
          
            likeButton.heightAnchor.constraint(equalToConstant: 25),
            likeButton.widthAnchor.constraint(equalToConstant: 25),
            likeButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
   
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
