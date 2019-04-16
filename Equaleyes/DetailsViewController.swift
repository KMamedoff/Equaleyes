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
            infoImageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "Account Circle")) { result in
                switch result {
                case .success(let value):
                    let imageViewSize = CGSize(width: self.infoImageView.frame.width, height: self.infoImageView.frame.height)
                    let imageAspectRatio = value.image.size.height / value.image.size.width
                    
                    self.imageViewConstraint.constant = imageViewSize.width * imageAspectRatio
                    UIView.animate(withDuration: 0.2) {
                        self.view.layoutIfNeeded()
                    }
                case .failure(_):
                    self.infoImageView.image = UIImage(named: "Account Circle")
                }
            }
        }
        /*
        if let name = self.teacherData[indexPath.row].name {
            cell.userInfoTextView.text = "\(name)\n"
        }
        
        if let teacherClass = self.teacherData[indexPath.row].teacherClass {
            cell.userInfoTextView.text += "Class:      \(teacherClass)\n"
        }
        
        if let schoolName = self.teacherData[indexPath.row].schoolName {
            cell.userInfoTextView.text += "School:   \(schoolName)\n"
        }
*/
    }
    
    @IBAction func contactButtonAction(_ sender: UIButton) {
        
    }
}
