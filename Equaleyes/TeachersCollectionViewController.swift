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
        
        let teacherUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers"
        NetworkingService.shared.fetchData(urlString: teacherUrl) { (posts: [Teacher]) in
            self.teacherData = posts

            for (index, _) in self.teacherData.enumerated() {
                guard let schoolId = self.teacherData[index].schoolId else { return }
                let schoolUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/schools/\(schoolId)"
                NetworkingService.shared.fetchData(urlString: schoolUrl) { (posts: School) in
                    self.teacherData[index].school = posts
                    
                    self.collectionView.reloadData()
                }
                
                guard let teacherDescriptionId = self.teacherData[index].id else { return }
                let teacherDescriptionUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers/\(teacherDescriptionId)"
                NetworkingService.shared.fetchData(urlString: teacherDescriptionUrl) { (posts: Teacher) in
                    self.teacherData[index].description = posts.description
                    
                    self.collectionView.reloadData()
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
            cell.userProfileImageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "Account Circle")) { result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    cell.userProfileImageView.image = UIImage(named: "Account Circle")
                }
            }
        }
        
        if let name = self.teacherData[indexPath.row].name {
            cell.userInfoTextView.text = "\(name)\n"
        }
        
        if let teacherClass = self.teacherData[indexPath.row].teacherClass {
            cell.userInfoTextView.text += "Class:      \(teacherClass)\n"
        }

        if let schoolName = self.teacherData[indexPath.row].school?.name {
            cell.userInfoTextView.text += "School:   \(schoolName)\n"
        }
        
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
