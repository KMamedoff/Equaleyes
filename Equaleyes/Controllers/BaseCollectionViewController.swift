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
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 20
        
        let width = UIScreen.main.bounds.size.width - layout.sectionInset.left - layout.sectionInset.right
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        
        return layout
    }()
    
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
        collectionView?.bounces = true
        collectionView?.alwaysBounceVertical = true
        collectionView?.collectionViewLayout = layout
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width - 32, height: 10)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        layout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseCollectionViewCell<U>
        
        cell.configure(text: items[indexPath.row])
        
        return cell
    }
    
}
