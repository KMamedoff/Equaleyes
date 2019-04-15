//
//  IBDesignables.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 15/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

@IBDesignable class UITextViewFixed: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
}
