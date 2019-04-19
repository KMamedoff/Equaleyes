//
//  StudentsCollectionViewController.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 19/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class StudentsCollectionViewController: BaseCollectionViewController<StudentCell, Student> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        customizeUI()
    }
    
    fileprivate func customizeUI() {
        if environment == .development {
            self.title = "student_title".localizedString() + " - DEV"
        }
    }
    
    fileprivate func fetchData() {
        let teacherUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/students"
        NetworkingService.shared.fetchData(urlString: teacherUrl) { [unowned self] (students: [Student]) in
            self.items = students
            self.collectionView.reloadData()
            
            for (index, _) in self.items.enumerated() {
                guard let teacherId = self.items[index].id else { return }
                let teacherDescriptionUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/students/\(teacherId)"
                NetworkingService.shared.fetchData(urlString: teacherDescriptionUrl) { [unowned self] (descriptions: Student) in
                    self.items[index].description = descriptions.description
                }
                
                guard let schoolId = self.items[index].schoolId else { return }
                let schoolUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/schools/\(schoolId)"
                NetworkingService.shared.fetchData(urlString: schoolUrl) { [unowned self] (schools: School) in
                    self.items[index].school = schools
                    
                    DispatchQueue.main.async {
                        self.collectionView.performBatchUpdates ({
                            let indexPath = IndexPath(row: index, section: 0)
                            self.collectionView.reloadItems(at: [indexPath])
                        }, completion: { (finished: Bool) in
                            UIViewPropertyAnimator(duration: 0.3, curve: .easeIn, animations: {
                                self.collectionView.collectionViewLayout.invalidateLayout()
                            }).startAnimation()
                        })
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Student Details Segue" {
            let detailsVC = segue.destination as! DetailsViewController
            let indexPath = sender as! IndexPath
            detailsVC.detailsData = self.items[indexPath.row]
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Student Details Segue", sender: indexPath)
    }
    
}
