//
//  Classes.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 17/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class ContactActionSheet {
    static func presentContactActionSheet(sender: UIView) {
        UIApplication.topViewController()!.customContactAlert(sender: sender, title: "contact_button_title".localizedString(), message: nil, preferredStyle: .actionSheet, actions: [
            UIAlertAction(title: "contact_email".localizedString(), style: .default) { action in },
            UIAlertAction(title: "contact_message".localizedString(), style: .default) { action in },
            UIAlertAction(title: "contact_call".localizedString(), style: .default) { action in },
            UIAlertAction(title: "contact_cancel".localizedString(), style: .cancel) { action in },
            ])
    }
}

class ContactButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        layer.masksToBounds = true
        layer.cornerRadius = 16
        titleLabel?.font = Font.contact
        setTitle("contact_button_title".localizedString(), for: .normal)
        setTitleColor(.white, for: .normal)
        setTitleColor(.lightGray, for: .highlighted)
        backgroundColor = UIColor(red:0.15, green:0.13, blue:0.37, alpha:1.00)
    }
}
