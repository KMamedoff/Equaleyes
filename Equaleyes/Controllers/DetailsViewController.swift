//
//  DetailsViewController.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 16/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet weak var portraitImageViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var shortInfoTextView: UITextViewFixed!
    @IBOutlet weak var contactButtonOutlet: UIButton!
    @IBOutlet weak var longInfoTextView: UITextViewFixed!
    
    fileprivate var shortInfoMutableAttributedString = NSMutableAttributedString()
    fileprivate var longInfoMutableAttributedString = NSMutableAttributedString()
    fileprivate var isTeacher = false
    
    var detailsData: Any? {
        didSet {
            if detailsData is Teacher {
                isTeacher = true
            } else if detailsData is Student {
                isTeacher = false
            }
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeUI()
    }
    
    fileprivate func customizeUI() {
        self.title = "details_title".localizedString()
        
        contactButtonOutlet.setTitle("contact_button_title".localizedString(), for: .normal)
        
        isTeacher ? fillTeacherInfo(detailsData: detailsData as! Teacher) : fillStudentInfo(detailsData: detailsData as! Student)
    }
    
    fileprivate func fillTeacherInfo(detailsData: Teacher) {
        contactButtonOutlet.isHidden = false
        
        // Image View
        if let imageUrl = detailsData.school?.imageUrl {
            infoImageView.setImageWithKingfisher(with: imageUrl) { result in
                switch result {
                case .success(let value):
                    self.resizeImageView(value)
                case .failure(_):
                    self.infoImageView.image = UIImage(named: "No Image")
                }
            }
        }
        
        // Short Info
        if let name = detailsData.name {
            shortInfoMutableAttributedString.append("\(name)\n".customAttributedString(font: Font.header, textColor: UIColor.darkGray))
        }
        
        if let teacherClass = detailsData.teacherClass {
            let teacherClassLocalizedString = "class".localizedString() + ": \(teacherClass)\n"
            shortInfoMutableAttributedString.append(teacherClassLocalizedString.customAttributedString(font: Font.content, textColor: UIColor.darkGray))
        }
        
        if let schoolName = detailsData.school?.name {
            let schoolNameLocalizedString = "school".localizedString() + ": \(schoolName)"
            shortInfoMutableAttributedString.append(schoolNameLocalizedString.customAttributedString(font: Font.content, textColor: UIColor.darkGray))
        }
        
        shortInfoTextView.attributedText = shortInfoMutableAttributedString
        
        // Long Info
        if let description = detailsData.description {
            if description != "" {
                let longInfoTitle = "details_about_title".localizedString() + "\n"
                longInfoMutableAttributedString.append(longInfoTitle.customAttributedString(font: Font.header, textColor: UIColor.darkGray))
                
                let longInfoDescription = "\(description)"
                longInfoMutableAttributedString.append(longInfoDescription.customAttributedString(font: Font.content, textColor: UIColor.darkGray))
            }
        }
        
        longInfoTextView.attributedText = longInfoMutableAttributedString
    }
    
    fileprivate func fillStudentInfo(detailsData: Student) {
        contactButtonOutlet.isHidden = true
        
        // Image View
        if let imageUrl = detailsData.school?.imageUrl {
            infoImageView.setImageWithKingfisher(with: imageUrl) { result in
                switch result {
                case .success(let value):
                    self.resizeImageView(value)
                case .failure(_):
                    self.infoImageView.image = UIImage(named: "No Image")
                }
            }
        }
        
        // Short Info
        if let name = detailsData.name {
            shortInfoMutableAttributedString.append("\(name)\n".customAttributedString(font: Font.header, textColor: UIColor.darkGray))
        }
        
        if let grade = detailsData.grade {
            let teacherClassLocalizedString = "grade".localizedString() + ": \(grade)\n"
            shortInfoMutableAttributedString.append(teacherClassLocalizedString.customAttributedString(font: Font.content, textColor: UIColor.darkGray))
        }
        
        if let schoolName = detailsData.school?.name {
            let schoolNameLocalizedString = "school".localizedString() + ": \(schoolName)"
            shortInfoMutableAttributedString.append(schoolNameLocalizedString.customAttributedString(font: Font.content, textColor: UIColor.darkGray))
        }
        
        shortInfoTextView.attributedText = shortInfoMutableAttributedString
        
        // Long Info
        if let description = detailsData.description {
            if description != "" {
                let longInfoTitle = "details_about_title".localizedString() + "\n"
                longInfoMutableAttributedString.append(longInfoTitle.customAttributedString(font: Font.header, textColor: UIColor.darkGray))
                
                let longInfoDescription = "\(description)"
                longInfoMutableAttributedString.append(longInfoDescription.customAttributedString(font: Font.content, textColor: UIColor.darkGray))
            }
        }
        
        longInfoTextView.attributedText = longInfoMutableAttributedString
    }
    
    fileprivate func resizeImageView(_ value: RetrieveImageResult) {
        let imageViewSize = infoImageView.frame.size
        let imageAspectRatio = value.image.size.height / value.image.size.width
        
        self.portraitImageViewConstraint.constant = imageViewSize.width * imageAspectRatio
        
        if self.portraitImageViewConstraint.constant >= UIScreen.main.bounds.height * 0.4 {
            self.portraitImageViewConstraint.constant = UIScreen.main.bounds.height * 0.4
        }
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func contactButtonAction(_ sender: UIButton) {
        ContactActionSheet.presentContactActionSheet()
    }
}
