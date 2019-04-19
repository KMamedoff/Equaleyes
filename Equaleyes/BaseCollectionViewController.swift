//
//  BaseCollectionViewController.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 19/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

class BaseCollectionViewController<T: BaseCollectionViewCell<U>, U>: UICollectionViewController {
    
    fileprivate let cellId = "Base Cell"
    fileprivate var activityIndicator = UIActivityIndicatorView()

    var items = [U]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        collectionView?.backgroundColor = .white
        collectionView?.register(T.self, forCellWithReuseIdentifier: cellId)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.delaysContentTouches = false // A "fix" for Contact button
        collectionView?.contentInsetAdjustmentBehavior = .always
        
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    @objc(collectionView:layout:minimumLineSpacingForSectionAtIndex:) func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if items.count == 0 {
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
        
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseCollectionViewCell<U>
        cell.item = items[indexPath.row]
        return cell
    }
    
    func reloadCollectionViewDataWithAnimation() {
        UIView.transition(with: self.collectionView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.collectionView.reloadData()
        })
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
}
