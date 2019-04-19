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
    func customAttributedString(fontName: String, fontSize: CGFloat, textColor: UIColor) -> NSMutableAttributedString {
        let attribute: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: fontName, size: fontSize)!,
            .foregroundColor: textColor
        ]
        
        let attributedString = NSMutableAttributedString(string: self, attributes: attribute)
        
        return attributedString
    }
}

extension UIViewController {
    func customContactAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        actions.forEach { alertController.addAction($0) }
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UICollectionViewController {
    func reloadCollectionViewDataWithAnimation() {
        UIView.transition(with: self.collectionView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
}

extension UIImageView {
    func setImageWithKingfisher(with urlString: String, completion: @escaping (Result<RetrieveImageResult, KingfisherError>) -> ()) {
        guard let url = URL.init(string: urlString) else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(with: resource) { result in
            completion(result)
        }
    }
}
