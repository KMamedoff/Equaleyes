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
    
    var isTeacher = false
    var detailsData: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isTeacher {
            contactButtonOutlet.isHidden = false
        }
        
        let detailsDataCasted = detailsData as! Teacher
        
        if let imageUrl = detailsDataCasted.school?.imageUrl {
            
            infoImageView.setImageWithKingfisher(with: imageUrl) { result in
                switch result {
                case .success(let value):
                    let imageViewSize = CGSize(width: self.infoImageView.frame.width, height: self.infoImageView.frame.height)
                    let imageAspectRatio = value.image.size.height / value.image.size.width
                    
                    self.imageViewConstraint.constant = imageViewSize.width * imageAspectRatio
                    
                    if self.imageViewConstraint.constant > UIScreen.main.bounds.height * 0.4 {
                        self.imageViewConstraint.constant = UIScreen.main.bounds.height * 0.4
                    }
                    
                    UIView.animate(withDuration: 0.2) {
                        self.view.layoutIfNeeded()
                    }
                case .failure(_):
                    self.infoImageView.image = UIImage(named: "Account Circle")
                }
            }
        }

        if let name = detailsDataCasted.name {
            shortInfoTextView.text = "\(name)\n"
        }
        
        if let teacherClass = detailsDataCasted.teacherClass {
            shortInfoTextView.text += "Class:      \(teacherClass)\n"
        }
        
        if let schoolName = detailsDataCasted.school?.name {
            shortInfoTextView.text += "School:   \(schoolName)\n"
        }
        
        if let description = detailsDataCasted.description {
            longInfoTextView.text = "About\n" + description
        }
    }
    
    @IBAction func contactButtonAction(_ sender: UIButton) {
        
    }
}
