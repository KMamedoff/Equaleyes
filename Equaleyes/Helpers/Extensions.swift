//
//  Extensions.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 16/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit
import Kingfisher

extension String {
    func localizedString(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
}

extension UIApplication {
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}

extension String {
    func customAttributedString(font: UIFont, textColor: UIColor) -> NSMutableAttributedString {
        let attribute: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor
        ]
        
        let attributedString = NSMutableAttributedString(string: self, attributes: attribute)
        
        return attributedString
    }
}

extension UIViewController {
    func customContactAlert(sender: UIView, title: String?, message: String?, preferredStyle: UIAlertController.Style, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        actions.forEach { alertController.addAction($0) }
        
        if let popoverPresentationController = alertController.popoverPresentationController {
            popoverPresentationController.sourceView = sender
            popoverPresentationController.sourceRect = sender.bounds
        }
                
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIImageView {
    func setImageWithKingfisher(with urlString: String, completion: @escaping (Result<RetrieveImageResult, KingfisherError>) -> ()) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: urlString)) { result in
            completion(result)
        }
    }
}
