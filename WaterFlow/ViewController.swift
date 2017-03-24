//
//  ViewController.swift
//  WaterFlow
//
//  Created by 管章鹏 on 17/3/24.
//  Copyright © 2017年 stw. All rights reserved.
//

import UIKit
private let kCellID = "kCellID"

class ViewController: UIViewController
{
    fileprivate var itemCount = 100
    
    fileprivate lazy var collectionView : UICollectionView = {
        
        let layout = ZPFlowLayout()
        layout.columns=2
        layout.sectionInset=UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing=10
        layout.minimumInteritemSpacing=10
        layout.dataSource = self
       
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCellID)
        
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        
        view.addSubview(collectionView)
    }
}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func  collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.RandomColor()
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            itemCount += 100
            collectionView.reloadData()
        }
    }
    
}

extension ViewController : ZPFlowLayoutDataSource
{
    func zpFlowLayout(_ layout: ZPFlowLayout, cellForItemAt indexPath: IndexPath) -> CGFloat {
        let screenW = UIScreen.main.bounds.width
        return indexPath.item % 2 == 0 ? screenW * 2 / 3 : screenW * 0.5
    }
}

