//
//  ViewController.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/4/20.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import UIKit

class ChefIntroViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var chefList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(indexPath.row == 0) {
            var cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("chefPicCell", forIndexPath: indexPath) as! UICollectionViewCell
            return cell
        } else if(indexPath.row == 1) {
            var cell: chefIntroductionCell = collectionView.dequeueReusableCellWithReuseIdentifier("chefProfileCell", forIndexPath: indexPath) as! chefIntroductionCell
              return cell
        } else if(indexPath.row == 2) {
            let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("separatorCell", forIndexPath: indexPath) as! UICollectionViewCell
            return cell
        } else {
            let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("ingrdientCell", forIndexPath: indexPath) as! UICollectionViewCell
            return cell
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            let edgeInSets: UIEdgeInsets =  UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
            return edgeInSets
    }
    
    // Define cell sizes
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if(indexPath.row == 0) {
            return CGSizeMake(collectionView.bounds.width*0.95, collectionView.bounds.height/4)
        } else if(indexPath.row == 1) {
            return CGSizeMake(collectionView.bounds.width*0.95, collectionView.bounds.height * 0.1865)
        } else if(indexPath.row == 2) {
            return CGSizeMake(collectionView.bounds.width*0.95, collectionView.bounds.height * 0.0575)
        } else {
//            return CGSizeMake(collectionView.bounds.width*0.95, collectionView.bounds.height * 0.2242)
            return CGSizeMake(collectionView.bounds.width*0.95, collectionView.bounds.height * 0.1874)
        }
        
        
    }
    
}

