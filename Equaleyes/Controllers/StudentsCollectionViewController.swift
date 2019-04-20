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
            students.forEach { self.items.append($0) }
            
            var indexPathArray = [IndexPath]()
            
            for (index, _) in students.enumerated() {
                guard let studentId = self.items[(self.items.count - 1) - index].id else { return }
                let studentDescriptionUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/students/\(studentId)"
                NetworkingService.shared.fetchData(urlString: studentDescriptionUrl) { [unowned self] (descriptions: Student) in
                    self.items[(self.items.count - 1) - index].description = descriptions.description
                }
                
                guard let schoolId = students[(self.items.count - 1) - index].schoolId else { return }
                let schoolUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/schools/\(schoolId)"
                NetworkingService.shared.fetchData(urlString: schoolUrl) { [unowned self] (schools: School) in
                    self.items[(self.items.count - 1) - index].school = schools
                    
                    indexPathArray.append(IndexPath(item: (self.items.count - 1) - index, section: 0))
                    
                    if indexPathArray.count == students.count {
                        UIView.performWithoutAnimation {
                            self.collectionView.insertItems(at: indexPathArray)
                        }
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
