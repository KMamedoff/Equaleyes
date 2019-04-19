//
//  TeachersCollectionViewController.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 15/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit
import Kingfisher

class TeachersCollectionViewController: BaseCollectionViewController<TeacherCell, Teacher>, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        customizeUI()
    }
    
    fileprivate func customizeUI() {
        if environment == .development {
            self.title = "teacher_title".localizedString() + " - DEV"
        }
    }
    
    fileprivate func fetchData() {
        let teacherUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers"
        NetworkingService.shared.fetchData(urlString: teacherUrl) { [unowned self] (posts: [Teacher]) in
            self.items = posts

            self.reloadCollectionViewDataWithAnimation()

            for (index, _) in self.items.enumerated() {
                guard let teacherId = self.items[index].id else { return }
                let teacherDescriptionUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers/\(teacherId)"
                NetworkingService.shared.fetchData(urlString: teacherDescriptionUrl) { [unowned self] (posts: Teacher) in
                    self.items[index].description = posts.description
                }
                
                guard let schoolId = self.items[index].schoolId else { return }
                let schoolUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/schools/\(schoolId)"
                NetworkingService.shared.fetchData(urlString: schoolUrl) { [unowned self] (posts: School) in
                    self.items[index].school = posts
                    
                    self.collectionView.performBatchUpdates({
                        let indexPath = IndexPath(row: index, section: 0)
                        self.collectionView.reloadItems(at: [indexPath])
                    }, completion: nil)
                    
                    self.reloadCollectionViewDataWithAnimation()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftPadding = UIApplication.shared.keyWindow!.safeAreaInsets.left
        let rightPadding = UIApplication.shared.keyWindow!.safeAreaInsets.left
        let screenWidth = UIScreen.main.bounds.width
        var cellHeight = CGFloat()
        
        if let collectionViewCell = collectionView.cellForItem(at: indexPath) as? TeacherCell {
            cellHeight = 20 + collectionViewCell.userInfoTextView.sizeThatFits(collectionViewCell.userInfoTextView.bounds.size).height + 4 + collectionViewCell.contactButton.frame.height + 0
        }
        
        return CGSize(width: screenWidth - leftPadding - rightPadding - 20, height: cellHeight)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Teacher Details Segue" {
            let detailsVC = segue.destination as! DetailsViewController
            let indexPath = sender as! IndexPath
            detailsVC.isTeacher = true
            detailsVC.detailsData = self.items[indexPath.row]
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Teacher Details Segue", sender: indexPath)
    }
    
}
