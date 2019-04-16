//
//  DetailsViewController.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 16/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var InfoImageView: UIImageView!
    @IBOutlet weak var shortInfoTextView: UITextViewFixed!
    @IBOutlet weak var longInfoTextView: UITextViewFixed!
    
    var detailsData: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(detailsData)
    }
    
    @IBAction func contactButtonAction(_ sender: UIButton) {
        
    }
}
