//
//  DetailsViewController.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 16/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit
import Kingfisher

protocol DisplayablePerson {
    // You can just return a String value but it will make things more complicated for no good reason because each Struct have different properties so it is better to return NSMutableAttributedString in this case
    var shortInfoAttributedString: NSAttributedString? { get }
    var longInfoAttributedString: NSAttributedString? { get }
    var schoolImageUrl: String? { get }
    var isContactable: Bool { get } // A dummy variable for a dummy button
}

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var infoImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var contactButtonOutlet: ContactButton!
    @IBOutlet weak var shortInfoTextView: UITextViewFixed!
    @IBOutlet weak var longInfoTextView: UITextViewFixed!
    
    var personDetails: DisplayablePerson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeUI()
    }
    
    fileprivate func customizeUI() {
        self.title = "details_title".localizedString()
        
        contactButtonOutlet.setTitle("contact_button_title".localizedString(), for: .normal)
        
        guard let personDetails = personDetails else { return }
        fillPersonInfo(person: personDetails)
    }
    
    fileprivate func fillPersonInfo(person: DisplayablePerson) {
        shortInfoTextView.attributedText = person.shortInfoAttributedString
        longInfoTextView.attributedText = person.longInfoAttributedString
        
        guard let schoolImageUrl = person.schoolImageUrl else { return }
        infoImageView.setImageWithKingfisher(with: schoolImageUrl) { result in
            switch result {
            case .success(let value):
                self.resizeImageView(value)
            case .failure(_):
                self.infoImageView.image = UIImage(named: "No Image")
            }
        }
        
        if !person.isContactable {
            contactButtonOutlet.isHidden = true
        }
    }
    
    fileprivate func resizeImageView(_ value: RetrieveImageResult) {
        let infoImageAspectRatio = value.image.size.height / value.image.size.width
        
        infoImageViewHeightConstraint.constant = UIScreen.main.nativeBounds.width / UIScreen.main.nativeScale * infoImageAspectRatio
        
        if infoImageViewHeightConstraint.constant >= UIScreen.main.nativeBounds.height / UIScreen.main.nativeScale * 0.4 {
            infoImageViewHeightConstraint.constant = UIScreen.main.nativeBounds.height / UIScreen.main.nativeScale * 0.4
        }
        
        if value.cacheType.cached {
            infoImageView.layoutIfNeeded()
        } else {
            UIView.animate(withDuration: 0.3) {
                self.infoImageView.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func contactButtonAction(_ sender: UIButton) {
        ContactActionSheet.presentContactActionSheet(sender: contactButtonOutlet)
    }
    
}
