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
    fileprivate var detailsDataTeacher: Teacher?
    fileprivate var detailsDataStudent: Student?
    public var isTeacher = false
    public var detailsData: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeUIElements()
        selectTeacherOrStudent()
    }
    
    fileprivate func customizeUIElements() {
        self.title = "details_title".localizedString()
        
        contactButtonOutlet.setTitle("contact_button_title".localizedString(), for: .normal)
    }
    
    fileprivate func selectTeacherOrStudent() {
        if isTeacher {
            contactButtonOutlet.isHidden = false
            detailsDataTeacher = detailsData as? Teacher
            
            fillTeacherInfo()
        } else {
            contactButtonOutlet.isHidden = true
            detailsDataStudent = detailsData as? Student
            
            fillStudentInfo()
        }
    }
    
    fileprivate func resizeImageView(_ value: RetrieveImageResult) {
        let imageViewSize = CGSize(width: self.infoImageView.frame.width, height: self.infoImageView.frame.height)
        let imageAspectRatio = value.image.size.height / value.image.size.width
        
        self.portraitImageViewConstraint.constant = imageViewSize.width * imageAspectRatio
        
        if self.portraitImageViewConstraint.constant > UIScreen.main.bounds.height * 0.5 {
            self.portraitImageViewConstraint.constant = UIScreen.main.bounds.height * 0.5
        }
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate func fillTeacherInfo() {
        // Image View
        if let imageUrl = detailsDataTeacher?.school?.imageUrl {
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
        if let name = detailsDataTeacher?.name {
            shortInfoMutableAttributedString.append(attributedString(string: "\(name)\n", fontName: "AvenirNextCondensed-Medium", fontSize: 24, textColor: UIColor.darkGray))
        }
        
        if let teacherClass = detailsDataTeacher?.teacherClass {
            shortInfoMutableAttributedString.append(attributedString(string: "class".localizedString() + ": \(teacherClass)\n", fontName: "AvenirNextCondensed-Medium", fontSize: 14, textColor: UIColor.darkGray))
        }
        
        if let schoolName = detailsDataTeacher?.school?.name {
            shortInfoMutableAttributedString.append(attributedString(string: "school".localizedString() + ": \(schoolName)", fontName: "AvenirNextCondensed-Medium", fontSize: 14, textColor: UIColor.darkGray))
        }
        
        shortInfoTextView.attributedText = shortInfoMutableAttributedString
        
        // Long Info
        if let description = detailsDataTeacher?.description {
            if description != "" {
                longInfoMutableAttributedString.append(attributedString(string: "details_about_title".localizedString() + "\n", fontName: "AvenirNextCondensed-Medium", fontSize: 24, textColor: UIColor.darkGray))
                longInfoMutableAttributedString.append(attributedString(string: "\(description)", fontName: "AvenirNextCondensed-Medium", fontSize: 14, textColor: UIColor.darkGray))
            }
        }
        
        longInfoTextView.attributedText = longInfoMutableAttributedString
    }
    
    fileprivate func fillStudentInfo() {
        
    }
    
    @IBAction func contactButtonAction(_ sender: UIButton) {
        ContactActionSheet.presentContactActionSheet()
    }
}
