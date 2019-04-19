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
        
        contactButton.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    override var item: Student! {
        didSet {
            let mutableAttributedString = NSMutableAttributedString()
            
            if let name = item.name {
                mutableAttributedString.append("\(name)\n".customAttributedString(fontName: "AvenirNextCondensed-Medium", fontSize: 24, textColor: UIColor.darkGray))
            }
            
            if let grade = item.grade {
                let teacherClassLocalizedString = "grade".localizedString() + ": \(grade)\n"
                mutableAttributedString.append(teacherClassLocalizedString.customAttributedString(fontName: "AvenirNextCondensed-Medium", fontSize: 14, textColor: UIColor.darkGray))
            }
            
            if let schoolName = item.school?.name {
                let schoolNameLocalizedString = "school".localizedString() + ": \(schoolName)"
                mutableAttributedString.append(schoolNameLocalizedString.customAttributedString(fontName: "AvenirNextCondensed-Medium", fontSize: 14, textColor: UIColor.darkGray))
            }
            
            userInfoLabel.attributedText = mutableAttributedString
        }
    }
    */
}

