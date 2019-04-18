//
//  GenericCollectionViewController.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 18/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class GenericCollectionView: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView
    fileprivate var myData: [Teacher]
    fileprivate var activityIndicator = UIActivityIndicatorView()
    
    init(_ cv: UICollectionView, _ data: [Teacher]) {
        myData = data
        collectionView = cv
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Custom Cell")
        
        collectionView.delaysContentTouches = false // A "fix" for Contact button
        collectionView.contentInsetAdjustmentBehavior = .always
        
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if myData.count == 0 {
            activityIndicator.center = collectionView.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
            activityIndicator.color = UIColor.darkGray
            collectionView.addSubview(activityIndicator)
            activityIndicator.startAnimating()
        } else {
            if !activityIndicator.isHidden {
                activityIndicator.stopAnimating()
            }
        }
        
        return myData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Custom Cell", for: indexPath) as! CustomCollectionViewCell
        
        print(myData[indexPath.row].imageUrl)
        
        return cell
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Teacher Details Segue" {
            let detailsVC = segue.destination as! DetailsViewController
            let indexPath = sender as! IndexPath
            detailsVC.isTeacher = true
            detailsVC.detailsData = self.myData[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "Teacher Details Segue", sender: indexPath)
    }
}
