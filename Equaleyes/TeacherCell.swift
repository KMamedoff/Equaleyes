//
//  TeacherCell.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 19/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class TeacherCell: BaseCollectionViewCell<Teacher> {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure(text: Teacher!) {
        if let imageUrl = text?.imageUrl {
            userProfileImageView.setImageWithKingfisher(with: imageUrl) { result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    self.userProfileImageView.image = UIImage(named: "No Image")
                }
            }
        }
        
        let mutableAttributedString = NSMutableAttributedString()
        
        if let name = text?.name {
            mutableAttributedString.append("\(name)\n".customAttributedString(fontName: "AvenirNextCondensed-Medium", fontSize: 24, textColor: UIColor.darkGray))
        }
        
        if let teacherClass = text?.teacherClass {
            let teacherClassLocalizedString = "class".localizedString() + ": \(teacherClass)\n"
            mutableAttributedString.append(teacherClassLocalizedString.customAttributedString(fontName: "AvenirNextCondensed-Medium", fontSize: 14, textColor: UIColor.darkGray))
        }
        
        if let schoolName = text?.school?.name {
            let schoolNameLocalizedString = "school".localizedString() + ": \(schoolName)"
            mutableAttributedString.append(schoolNameLocalizedString.customAttributedString(fontName: "AvenirNextCondensed-Medium", fontSize: 14, textColor: UIColor.darkGray))
        }
        
        userInfoLabel.attributedText = mutableAttributedString
    }
    
}
