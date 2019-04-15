//
//  CustomCollectionViewCell.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 15/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userInfoTextView: UITextViewFixed!
    @IBOutlet weak var userContactButtonOutlet: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userContactButtonOutlet.layer.masksToBounds = true
        userContactButtonOutlet.layer.cornerRadius = 16
        
        
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
        attributedString.append(NSAttributedString(string: "Class: 10\n", attributes: classTextAttributes))
        attributedString.append(NSAttributedString(string: "School: Cavour Ave\n", attributes: schoolTextAttributes))

        userInfoTextView.attributedText = attributedString
        
        
        
    }
    
    @IBAction func contactButtonAction(_ sender: Any) {
        
    }
    
}
