//
//  StudentsCollectionViewController.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 18/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class StudentsCollectionViewController: UICollectionViewController {
    
    fileprivate var reusableCollectionView: GenericCollectionView!
    fileprivate var teacherData = [Teacher]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkingAndJSON()
    }
    
    fileprivate func networkingAndJSON() {
        let teacherUrl = "https://zpk2uivb1i.execute-api.us-east-1.amazonaws.com/dev/teachers"
        NetworkingService.shared.fetchData(urlString: teacherUrl) { [unowned self] (posts: [Teacher]) in
            self.teacherData = posts
            
            self.reusableCollectionView = GenericCollectionView(self.collectionView, self.teacherData)
            UIView.transition(with: self.collectionView, duration: 0.2, options: .transitionCrossDissolve, animations: { self.reusableCollectionView.collectionView.reloadData() })
            
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
                        self.reusableCollectionView.collectionView.reloadItems(at: [indexPath])
                    }, completion: nil)
                }
            }
        }
    }
    
    
    
    
    
    
}
