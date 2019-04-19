//
//  CustomCollectionViewCell.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 15/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class BaseCollectionViewCell<U>: UICollectionViewCell {

    var item: U!
    
    let roundedBackgroundView: UIView = {
        let roundedBackgroundView = UIView()
        roundedBackgroundView.translatesAutoresizingMaskIntoConstraints = false
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
        userProfileImageView.layer.cornerRadius = 35
        userProfileImageView.layer.borderWidth = 1.0
        userProfileImageView.layer.borderColor = UIColor.lightGray.cgColor
        return userProfileImageView
    }()
    
    let userInfoTextView: UITextView = {
        let userInfoTextView = UITextView()
        userInfoTextView.translatesAutoresizingMaskIntoConstraints = false
        userInfoTextView.isEditable = false
        userInfoTextView.isScrollEnabled = false
        return userInfoTextView
    }()
    
    let arrowImageView: UIImageView = {
        let arrowImageView = UIImageView()
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        return arrowImageView
    }()
    
    let contactButton: UIButton = {
        let contactButton = UIButton()
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        return contactButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(roundedBackgroundView)
        roundedBackgroundView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        roundedBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
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
        arrowImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        arrowImageView.backgroundColor = .red
        
        addSubview(userInfoTextView)
        userInfoTextView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        userInfoTextView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        let horizontalSpace = NSLayoutConstraint(item: userInfoTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 20)
        let horizontalSpace2 = NSLayoutConstraint(item: userInfoTextView, attribute: .right, relatedBy: .equal, toItem: arrowImageView, attribute: .left, multiplier: 1, constant: -20)
        NSLayoutConstraint.activate([horizontalSpace, horizontalSpace2])
        userInfoTextView.backgroundColor = .blue
        
        addSubview(contactButton)
        contactButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 15).isActive = true
        contactButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.44).isActive = true
        contactButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let horConstraint = NSLayoutConstraint(item: contactButton, attribute: .centerX, relatedBy: .equal, toItem: roundedBackgroundView, attribute: .centerX ,multiplier: 1.0, constant: 0.0)
        NSLayoutConstraint.activate([horConstraint])
        contactButton.backgroundColor = .black
        contactButton.addTarget(self, action: #selector(contactButtonAction), for: .touchUpInside)

        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
        layer.shouldRasterize = true // ask iOS to ache the rendered shadow so that it oesn't need to be redrawn
        layer.rasterizationScale = UIScreen.main.scale
        
        //        contactButtonOutlet.setTitle("contact_button_title".localizedString(), for: .normal)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func contactButtonAction(_ sender: Any) {
//        ContactActionSheet.presentContactActionSheet()
    }
    
}
