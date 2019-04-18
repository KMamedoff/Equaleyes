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
        UIApplication.topViewController()?.customContactAlert(title: "contact_button_title".localizedString(), message: nil, preferredStyle: .actionSheet, actions: [
            UIAlertAction(title: "contact_email".localizedString(), style: .default) { action in },
            UIAlertAction(title: "contact_message".localizedString(), style: .default) { action in },
            UIAlertAction(title: "contact_call".localizedString(), style: .default) { action in },
            UIAlertAction(title: "contact_cancel".localizedString(), style: .cancel) { action in },
            ])
    }
}
