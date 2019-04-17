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

    @IBOutlet weak var imageViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var shortInfoTextView: UITextViewFixed!
    @IBOutlet weak var contactButtonOutlet: UIButton!
    @IBOutlet weak var longInfoTextView: UITextViewFixed!
    
    private var shortInfoMutableAttributedString = NSMutableAttributedString()
    private var longInfoMutableAttributedString = NSMutableAttributedString()
    private var detailsDataTeacher: Teacher?
    private var detailsDataStudent: Student?
    public var isTeacher = false
    public var detailsData: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func resizeImageView(_ value: RetrieveImageResult) {
        let imageViewSize = CGSize(width: self.infoImageView.frame.width, height: self.infoImageView.frame.height)
        let imageAspectRatio = value.image.size.height / value.image.size.width
        
        self.imageViewConstraint.constant = imageViewSize.width * imageAspectRatio
        
        if self.imageViewConstraint.constant > UIScreen.main.bounds.height * 0.4 {
            self.imageViewConstraint.constant = UIScreen.main.bounds.height * 0.4
        }
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    func fillTeacherInfo() {
        // Image View
        if let imageUrl = detailsDataTeacher?.school?.imageUrl {
            infoImageView.setImageWithKingfisher(with: imageUrl) { result in
                switch result {
                case .success(let value):
                    self.resizeImageView(value)
                case .failure(_):
                    self.infoImageView.image = UIImage(named: "Account Circle")
                }
            }
        }
        
        // Short Info
        if let name = detailsDataTeacher?.name {
            shortInfoMutableAttributedString.append(attributedString(string: "\(name)\n", fontName: "AvenirNextCondensed-Medium", fontSize: 24, textColor: UIColor.darkGray))
        }
        
        if let teacherClass = detailsDataTeacher?.teacherClass {
            shortInfoMutableAttributedString.append(attributedString(string: "Class:      \(teacherClass)\n", fontName: "AvenirNextCondensed-Medium", fontSize: 14, textColor: UIColor.darkGray))
        }
        
        if let schoolName = detailsDataTeacher?.school?.name {
            shortInfoMutableAttributedString.append(attributedString(string: "School:   \(schoolName)", fontName: "AvenirNextCondensed-Medium", fontSize: 14, textColor: UIColor.darkGray))
        }
        
        shortInfoTextView.attributedText = shortInfoMutableAttributedString
        
        // Long Info
        longInfoMutableAttributedString.append(attributedString(string: "About\n", fontName: "AvenirNextCondensed-Medium", fontSize: 24, textColor: UIColor.darkGray))
        
        if let description = detailsDataTeacher?.description {
            longInfoMutableAttributedString.append(attributedString(string: "School:   \(description)", fontName: "AvenirNextCondensed-Medium", fontSize: 14, textColor: UIColor.darkGray))
        }
        
        longInfoTextView.attributedText = longInfoMutableAttributedString
    }
    
    func fillStudentInfo() {
        
    }
    
    @IBAction func contactButtonAction(_ sender: UIButton) {
        
    }
}
