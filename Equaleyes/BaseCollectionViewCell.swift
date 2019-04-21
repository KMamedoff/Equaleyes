//
//  CustomCollectionViewCell.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 15/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class BaseCollectionViewCell<U>: UICollectionViewCell {
    
    let roundedBackgroundView: UIView = {
        let roundedBackgroundView = UIView()
        roundedBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        roundedBackgroundView.isUserInteractionEnabled = false
        roundedBackgroundView.backgroundColor = .white
        roundedBackgroundView.layer.borderWidth = 1
        roundedBackgroundView.layer.cornerRadius = 20
        roundedBackgroundView.layer.borderColor = UIColor.clear.cgColor
        roundedBackgroundView.layer.masksToBounds = true
        
        return roundedBackgroundView
    }()
    
    let userProfileImageView: UIImageView = {
        let userProfileImageView = UIImageView()
        userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        userProfileImageView.image = UIImage(named: "No Image")
        userProfileImageView.isUserInteractionEnabled = false
        userProfileImageView.layer.cornerRadius = 35
        userProfileImageView.layer.borderWidth = 1.0
        userProfileImageView.layer.borderColor = UIColor.lightGray.cgColor
        userProfileImageView.layer.masksToBounds = true
        
        return userProfileImageView
    }()
    
    let userInfoLabel: UILabel = {
        let userInfoLabel = UILabel()
        userInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        userInfoLabel.backgroundColor = .clear
        userInfoLabel.isUserInteractionEnabled = false
        userInfoLabel.numberOfLines = 0
        
        return userInfoLabel
    }()
    
    let arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.isUserInteractionEnabled = false
        arrowImageView.image = UIImage(named: "Path")
        arrowImageView.contentMode = .scaleAspectFit
        
        return arrowImageView
    }()
    
    let contactButton: UIButton = {
        let contactButton = UIButton()
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        contactButton.layer.masksToBounds = true
        contactButton.layer.cornerRadius = 16
        contactButton.titleLabel?.font = Font.contact
        contactButton.setTitle("contact_button_title".localizedString(), for: .normal)
        contactButton.setTitleColor(.white, for: .normal)
        contactButton.setTitleColor(.lightGray, for: .highlighted)
        contactButton.backgroundColor = UIColor(red:0.15, green:0.13, blue:0.37, alpha:1.00)

        return contactButton
    }()
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        
        return width
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layerProperties()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    func configure(text: U!) {
        
    }
    
    fileprivate func layerProperties() {
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
        layer.shouldRasterize = true // Ask iOS to cache the rendered shadow so that it doesn't need to be redrawn
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    fileprivate func setupViews() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        roundedBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        roundedBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        roundedBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        contentView.addSubview(userProfileImageView)
        userProfileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        userProfileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        contentView.addSubview(arrowImageView)
        arrowImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        arrowImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        contentView.addSubview(userInfoLabel)
        userInfoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        userInfoLabel.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 20).isActive = true
        userInfoLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -20).isActive = true
        
        contentView.addSubview(contactButton)
        contactButton.topAnchor.constraint(equalTo: userInfoLabel.bottomAnchor, constant: 10).isActive = true
        contactButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        contactButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        contactButton.widthAnchor.constraint(equalToConstant: contentView.bounds.width * 0.44).isActive = true
    }
    
    @objc func contactButtonAction(_ sender: Any) {
        ContactActionSheet.presentContactActionSheet()
    }
    
}
