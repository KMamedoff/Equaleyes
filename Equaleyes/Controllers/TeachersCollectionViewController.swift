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
            for _ in 0...15 {
                //self.items.append(teachers[Int.random(in: 0...1)])
            }
            self.items = teachers
            self.collectionView.reloadData()
            
            for (index, _) in self.items.enumerated() {
                guard let teacherId = self.items[index].id else { return }
                let teacherDescriptionUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers/\(teacherId)"
                NetworkingService.shared.fetchData(urlString: teacherDescriptionUrl) { [unowned self] (descriptions: Teacher) in
                    self.items[index].description = descriptions.description
                }
                
                guard let schoolId = self.items[index].schoolId else { return }
                let schoolUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/schools/\(schoolId)"
                NetworkingService.shared.fetchData(urlString: schoolUrl) { [unowned self] (schools: School) in
                    self.items[index].school = schools
                    
                    self.collectionView.performBatchUpdates({
                        self.collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
                    }, completion: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Teacher Details Segue" {
            let detailsVC = segue.destination as! DetailsViewController
            let indexPath = sender as! IndexPath
            detailsVC.detailsData = self.items[indexPath.row]
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Teacher Details Segue", sender: indexPath)
    }
    
}
