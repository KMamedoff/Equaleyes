//
//  Classes.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 17/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class ContactActionSheet {
    static func presentContactActionSheet() {
        UIApplication.topViewController()?.customContactAlert(title: "contact_button_title".localized(), message: nil, preferredStyle: .actionSheet, actions: [
            UIAlertAction(title: "contact_email".localized(), style: .default) { action in },
            UIAlertAction(title: "contact_message".localized(), style: .default) { action in },
            UIAlertAction(title: "contact_call".localized(), style: .default) { action in },
            UIAlertAction(title: "contact_cancel".localized(), style: .cancel) { action in },
            ])
    }
}
