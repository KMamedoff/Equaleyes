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
    
    fileprivate var teacherData = [Teacher]()
    fileprivate var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkingAndJSON()
        customizeUIElements()
    }
    
    fileprivate func customizeUIElements() {
        if environment == .development {
            self.title = "teacher_title".localized() + " - DEV"
        }
        
        self.collectionView!.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Custom Cell")
        self.collectionView.delaysContentTouches = false // A "fix" for Contact button
        self.collectionView.contentInsetAdjustmentBehavior = .always

        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    fileprivate func networkingAndJSON() {
        let teacherUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers"
        NetworkingService.shared.fetchData(urlString: teacherUrl) { [unowned self] (posts: [Teacher]) in
            self.teacherData = posts
            
            self.reloadCollectionViewDataWithAnimation()
            
            for (index, _) in self.teacherData.enumerated() {
                guard let teacherId = self.teacherData[index].id else { return }
                let teacherDescriptionUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers/\(teacherId)"
                NetworkingService.shared.fetchData(urlString: teacherDescriptionUrl) { [unowned self] (posts: Teacher) in
                    self.teacherData[index].description = posts.description
                    
                }
                
                guard let schoolId = self.teacherData[index].schoolId else { return }
                let schoolUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/schools/\(schoolId)"
                NetworkingService.shared.fetchData(urlString: schoolUrl) { [unowned self] (posts: School) in
                    self.teacherData[index].school = posts
                    
                    self.collectionView.performBatchUpdates({
                        let indexPath = IndexPath(row: index, section: 0)
                        self.collectionView.reloadItems(at: [indexPath])
                    }, completion: nil)
                }
            }
        }
    }
    
    fileprivate func reloadCollectionViewDataWithAnimation() {
        UIView.transition(with: self.collectionView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.collectionView.reloadData()
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if teacherData.count == 0 {
            activityIndicator.center = view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
            activityIndicator.color = UIColor.darkGray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        } else {
            if !activityIndicator.isHidden {
                activityIndicator.stopAnimating()
            }
        }
        
        return teacherData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom Cell", for: indexPath) as! CustomCollectionViewCell
        cell.teachersCellTextViewConstraint.isActive = true
        
        if let imageUrl = self.teacherData[indexPath.row].imageUrl {
            cell.userProfileImageView.setImageWithKingfisher(with: imageUrl) { result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    cell.userProfileImageView.image = UIImage(named: "No Image")
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftPadding = UIApplication.shared.keyWindow!.safeAreaInsets.left
        let rightPadding = UIApplication.shared.keyWindow!.safeAreaInsets.left
        let screenWidth = UIScreen.main.bounds.width
        let screenOrientation = UIDevice.current.orientation
        let defaultCellHeight: CGFloat = 150
        
        if screenOrientation.isLandscape && screenWidth >= 667.0 {
            return CGSize(width: (screenWidth - leftPadding - rightPadding - 34) / 2, height: defaultCellHeight)
        } else {
            return CGSize(width: screenWidth - leftPadding - rightPadding - 20, height: defaultCellHeight)
        }
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
