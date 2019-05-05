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
    
    fileprivate var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .whiteLarge
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        
        return activityIndicatorView
    }()
    
    fileprivate var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 20
        layout.estimatedItemSize = CGSize(width: 1, height: 1)
        
        return layout
    }()
    
    var items = [U]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        // Activity Indicator View
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        // Collection View
        collectionView?.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.00)
        collectionView?.register(T.self, forCellWithReuseIdentifier: cellId)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.delaysContentTouches = false // A "fix" for Contact button
        collectionView?.bounces = true
        collectionView?.alwaysBounceVertical = true
        collectionView?.contentInsetAdjustmentBehavior = .always
        collectionView?.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if items.count != 0 {
            activityIndicatorView.stopAnimating()
        }
        
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = layout.sectionInset
        let referenceHeight: CGFloat = 1
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
    
}
