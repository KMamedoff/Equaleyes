//
//  TeachersCollectionViewController.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 15/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit
import Kingfisher

class TeachersCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var teacherData = [Teacher]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkingAndJSON()
        customizeUIElements()
    }
    
    private func customizeUIElements() {
        if environment == .development {
            self.title = "teacher_title".localized() + " DEV"
        }
        
        self.collectionView!.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Custom Cell")
        self.collectionView.delaysContentTouches = false // A "fix" for Contact button
        
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    private func networkingAndJSON() {
        let teacherUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers"
        NetworkingService.shared.fetchData(urlString: teacherUrl) { (posts: [Teacher]) in
            self.teacherData = posts
            
            for (index, _) in self.teacherData.enumerated() {
                guard let schoolId = self.teacherData[index].schoolId else { return }
                let schoolUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/schools/\(schoolId)"
                NetworkingService.shared.fetchData(urlString: schoolUrl) { (posts: School) in
                    self.teacherData[index].school = posts
                    
                    self.reloadWithAnimation()
                }
                
                guard let teacherDescriptionId = self.teacherData[index].id else { return }
                let teacherDescriptionUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers/\(teacherDescriptionId)"
                NetworkingService.shared.fetchData(urlString: teacherDescriptionUrl) { (posts: Teacher) in
                    self.teacherData[index].description = posts.description
                    
                    self.reloadWithAnimation()
                }
            }
        }
    }
    
    private func reloadWithAnimation() {
        UIView.transition(with: self.collectionView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.collectionView.reloadData()
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teacherData.count
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom Cell", for: indexPath) as! CustomCollectionViewCell
        cell.teachersCellTextViewConstraint.isActive = true
        
        if let imageUrl = self.teacherData[indexPath.row].imageUrl {
            cell.userProfileImageView.setImageWithKingfisher(with: imageUrl) { result in
                switch result {
                case .success(_):
                    print()
                case .failure(_):
                    cell.userProfileImageView.image = UIImage(named: "Account Circle")
                }
            }
        }
        
        let mutableAttributedString = NSMutableAttributedString()
        
        if let name = self.teacherData[indexPath.row].name {
            mutableAttributedString.append(attributedString(string: "\(name)\n", fontName: "AvenirNextCondensed-Medium", fontSize: 24, textColor: UIColor.darkGray))
        }
        
        if let teacherClass = self.teacherData[indexPath.row].teacherClass {
            mutableAttributedString.append(attributedString(string: "class".localized() + ": \(teacherClass)\n", fontName: "AvenirNextCondensed-Medium", fontSize: 14, textColor: UIColor.darkGray))
        }
        
        if let schoolName = self.teacherData[indexPath.row].school?.name {
            mutableAttributedString.append(attributedString(string: "school".localized() + ": \(schoolName)\n", fontName: "AvenirNextCondensed-Medium", fontSize: 14, textColor: UIColor.darkGray))
        }
        
        cell.userInfoTextView.attributedText = mutableAttributedString
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.94, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Item Details Segue" {
            let detailsVC = segue.destination as! DetailsViewController
            let indexPath = sender as! IndexPath
            detailsVC.isTeacher = true
            detailsVC.detailsData = self.teacherData[indexPath.row]
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Item Details Segue", sender: indexPath)
    }
    
}
