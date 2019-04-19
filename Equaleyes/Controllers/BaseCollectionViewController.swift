//
//  BaseCollectionViewController.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 19/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class BaseCollectionViewController<T: BaseCollectionViewCell<U>, U>: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "Base Cell"
    fileprivate var activityIndicator = UIActivityIndicatorView()

    var items = [U]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        collectionView?.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.00)
        collectionView?.register(T.self, forCellWithReuseIdentifier: cellId)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.delaysContentTouches = false // A "fix" for Contact button
        collectionView?.contentInsetAdjustmentBehavior = .always
        
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        flow.minimumLineSpacing = 20
        flow.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        //        flow.sectionInsetReference = .fromLayoutMargins
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if items.count == 0 {
            view.addSubview(activityIndicator)
            activityIndicator.center = view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
            activityIndicator.color = UIColor.darkGray
            activityIndicator.startAnimating()
        } else {
            if !activityIndicator.isHidden {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        let referenceHeight: CGFloat = 100
        let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right
        return CGSize(width: referenceWidth, height: referenceHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseCollectionViewCell<U>

        cell.configure(text: items[indexPath.row])
        
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
}