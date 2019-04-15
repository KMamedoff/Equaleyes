//
//  StudentsCollectionViewController.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 15/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class StudentsCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/students"
        NetworkingService.shared.getRequest(urlString: url) { (feed: [Student]) in
            
        }
        
        self.collectionView!.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Custom Cell") // Register Custom Cell
        
        self.collectionView.delaysContentTouches = false // A fix for UIButtons
        
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0) // Top and Bottom insets
    }
    
}

extension StudentsCollectionViewController: UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom Cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.studentsCellTextViewConstraint.isActive = true
        cell.studentsCellTextViewConstraint.constant = 0
        cell.userContactButtonOutlet.isHidden = true
        
        cell.contentView.layer.cornerRadius = 20.0
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOpacity = 0.4
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.94, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
}
