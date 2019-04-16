//
//  CustomCollectionViewCell.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 15/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var roundedBackgroundView: UIView!
    @IBOutlet weak var studentsCellTextViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var teachersCellTextViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userInfoTextView: UITextViewFixed!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        
        self.roundedBackgroundView.layer.borderWidth = 1
        self.roundedBackgroundView.layer.cornerRadius = 20
        self.roundedBackgroundView.layer.borderColor = UIColor.clear.cgColor
        self.roundedBackgroundView.layer.masksToBounds = true
        
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true // ask iOS to cache the rendered shadow so that it doesn't need to be redrawn
        self.layer.rasterizationScale = UIScreen.main.scale
        
        userProfileImageView.layer.cornerRadius = userProfileImageView.layer.bounds.width / 2
        userProfileImageView.layer.borderWidth = 1.0
        userProfileImageView.layer.borderColor = UIColor.lightGray.cgColor
                
        let usernameTextAttributes: [NSAttributedString.Key: Any] = [
            .font : UIFont(name: "AvenirNextCondensed-Medium", size: 26)!,
            .foregroundColor: UIColor.darkGray
        ]
        let classTextAttributes: [NSAttributedString.Key: Any] = [
            .font : UIFont(name: "AvenirNextCondensed-Medium", size: 14)!,
            .foregroundColor: UIColor.darkGray
        ]
        let schoolTextAttributes: [NSAttributedString.Key: Any] = [
            .font : UIFont(name: "AvenirNextCondensed-Medium", size: 14)!,
            .foregroundColor: UIColor.darkGray
        ]

        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: "Roger Mills\n", attributes: usernameTextAttributes))
        attributedString.append(NSAttributedString(string: "Class:    10\n", attributes: classTextAttributes))
        attributedString.append(NSAttributedString(string: "School:   Cavour Ave\n", attributes: schoolTextAttributes))

        userInfoTextView.attributedText = attributedString        
    }
    
    @IBAction func contactButtonAction(_ sender: Any) {
        if let parentVC = self.parentController {
            parentVC.alert(title: "Contact", message: nil, preferredStyle: .actionSheet, actions: [
            UIAlertAction(title: "Email", style: .default) { action in },
            UIAlertAction(title: "Message", style: .default) { action in },
            UIAlertAction(title: "Call", style: .default) { action in },
            UIAlertAction(title: "Cancel", style: .cancel) { action in },
                ])
        }
    }
    
}
