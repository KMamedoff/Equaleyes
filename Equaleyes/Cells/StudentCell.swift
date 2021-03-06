//
//  StudentCell.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 19/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class StudentCell: BaseCollectionViewCell<Student> {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contactButton.removeFromSuperview()
        if let lastSubview = contentView.subviews.last {
            contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 20).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(text: Student!) {
        let mutableAttributedString = NSMutableAttributedString()
        
        userProfileImageView.image = UIImage(named: "No Image")
        
        if let name = text?.name {
            mutableAttributedString.append("\(name)\n".customAttributedString(font: Font.header, textColor: UIColor.darkGray))
        }
        
        if let grade = text?.grade {
            let teacherClassLocalizedString = "grade".localizedString() + ": \(grade)\n"
            mutableAttributedString.append(teacherClassLocalizedString.customAttributedString(font: Font.content, textColor: UIColor.darkGray))
        }
        
        if let schoolName = text?.school?.name {
            let schoolNameLocalizedString = "school".localizedString() + ": \(schoolName)"
            mutableAttributedString.append(schoolNameLocalizedString.customAttributedString(font: Font.content, textColor: UIColor.darkGray))
        }
        
        userInfoLabel.attributedText = mutableAttributedString
    }
    
}
