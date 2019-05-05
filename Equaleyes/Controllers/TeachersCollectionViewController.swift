//
//  TeachersCollectionViewController.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 15/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class TeachersCollectionViewController: BaseCollectionViewController<TeacherCell, Teacher> {
    
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
        NetworkingService.shared.fetchData(urlString: teacherUrl) { [unowned self] (teachers: [Teacher]) in
            teachers.forEach { self.items.append($0) }
            
            var indexPathArray = [IndexPath]()
            
            for (index, _) in teachers.enumerated() {
                guard let teacherId = self.items[(self.items.count - 1) - index].id else { return }
                let teacherDescriptionUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers/\(teacherId)"
                NetworkingService.shared.fetchData(urlString: teacherDescriptionUrl) { [unowned self] (descriptions: Teacher) in
                    self.items[(self.items.count - 1) - index].description = descriptions.description
                }
                
                guard let schoolId = self.items[(self.items.count - 1) - index].schoolId else { return }
                let schoolUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/schools/\(schoolId)"
                NetworkingService.shared.fetchData(urlString: schoolUrl) { [unowned self] (schools: School) in
                    self.items[(self.items.count - 1) - index].school = schools
                    
                    indexPathArray.append(IndexPath(item: (self.items.count - 1) - index, section: 0))
                    
                    if indexPathArray.count == teachers.count {
                        let indexPathArraySorted = indexPathArray.sorted { ($0[1]) < ($1[1]) }
                        
                        self.collectionView.performBatchUpdates({
                            self.collectionView.insertItems(at: indexPathArraySorted)
                        }, completion: { (finished) in
                            
                        })
                    }
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Teacher Details Segue" {
            let detailsVC = segue.destination as! DetailsViewController
            let indexPath = sender as! IndexPath
            detailsVC.personDetails = self.items[indexPath.row]
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Teacher Details Segue", sender: indexPath)
    }
    
}
