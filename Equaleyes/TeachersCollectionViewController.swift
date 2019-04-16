//
//  TeachersCollectionViewController.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 15/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit
import Kingfisher

class TeachersCollectionViewController: UICollectionViewController {
    
    var teacherData = [Teacher]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let teacherUrla = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers"
        NetworkingService.shared.fetchData(urlString: teacherUrla) { (posts: [Teacher]) in
            self.teacherData = posts

            for (index, _) in self.teacherData.enumerated() {
                guard let schoolId = self.teacherData[index].schoolId else { return }
                let schoolUrla = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/schools/\(schoolId)"
                NetworkingService.shared.fetchData(urlString: schoolUrla) { (posts: School) in
                    self.teacherData[index].schoolName = posts.name
                    print(self.teacherData)
                    
                    UIView.transition(with: self.collectionView, duration: 0.35, options: .transitionCrossDissolve, animations: {
                        self.collectionView.reloadData()
                    })
                }
            }
            
            
        }
        
        
        
        
        
        
        self.collectionView!.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Custom Cell") // Register Custom Cell
        
        self.collectionView.delaysContentTouches = false // A fix for UIButtons

        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0) // Top and Bottom insets
    }
    
}

extension TeachersCollectionViewController: UICollectionViewDelegateFlowLayout {
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teacherData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom Cell", for: indexPath) as! CustomCollectionViewCell
        
        if let imageUrl = self.teacherData[indexPath.row].imageUrl {
            cell.userProfileImageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "Account Circle")) { result in
                switch result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                    cell.userProfileImageView.image = UIImage(named: "Account Circle")
                }
            }
        }
        
        if let name = self.teacherData[indexPath.row].name {
            cell.userInfoTextView.text = "\(name)\n"
        }
        
        if let teacherClass = self.teacherData[indexPath.row].teacherClass {
            cell.userInfoTextView.text += "\(teacherClass)\n"
        }
        
        
        
        
        
        cell.teachersCellTextViewConstraint.isActive = true
        
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
        return CGSize(width: UIScreen.main.bounds.width * 0.94, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
}
