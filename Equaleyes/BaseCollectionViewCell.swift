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
        userInfoLabel.lineBreakMode = .byWordWrapping
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
        contactButton.titleLabel?.font = UIFont(name: "AvenirNextCondensed-Regular", size: 14)
        contactButton.setTitle("contact_button_title".localizedString(), for: .normal)
        contactButton.setTitleColor(.white, for: .normal)
        contactButton.setTitleColor(.lightGray, for: .highlighted)
        contactButton.backgroundColor = UIColor(red:0.15, green:0.13, blue:0.37, alpha:1.00)

        return contactButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layerProperties()
        
        addSubview(roundedBackgroundView)
        roundedBackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        roundedBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        roundedBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        roundedBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(userProfileImageView)
        userProfileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        userProfileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        userProfileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true

        addSubview(arrowImageView)
        arrowImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        arrowImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        addSubview(contactButton)
        contactButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15).isActive = true
        contactButton.widthAnchor.constraint(equalTo: roundedBackgroundView.widthAnchor, multiplier: 0.44).isActive = true
        contactButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let horConstraint = NSLayoutConstraint(item: contactButton, attribute: .centerX, relatedBy: .equal, toItem: roundedBackgroundView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([horConstraint])
        contactButton.addTarget(self, action: #selector(contactButtonAction), for: .touchUpInside)
        
        addSubview(userInfoLabel)
        userInfoLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        userInfoLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -55).isActive = true
        
        let horizontalSpace = NSLayoutConstraint(item: userInfoLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 20)
        let horizontalSpace2 = NSLayoutConstraint(item: userInfoLabel, attribute: .right, relatedBy: .equal, toItem: arrowImageView, attribute: .left, multiplier: 1, constant: -20)
        NSLayoutConstraint.activate([horizontalSpace, horizontalSpace2])
        
        userInfoLabel.backgroundColor = .groupTableViewBackground
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: U!) {
        
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        userInfoLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.right
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        
        return layoutAttributes
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
    
    @objc func contactButtonAction(_ sender: Any) {
        ContactActionSheet.presentContactActionSheet()
    }
    
}
