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
    @IBOutlet weak var chefIntroTitile: UINavigationItem!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // show shopping cart page when clicked
    @IBAction func goToCart(sender: AnyObject) {
        var storyboard = UIStoryboard(name: "order", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("shoppingCart") as! UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("chefs", forKey: lastStoryBoard)
        defaults.setObject("chefIntro", forKey: lastViewController)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chefIntroTitile.title = selectedChef.name as? String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(indexPath.row == 0) {
            var cell: chefPicCell = collectionView.dequeueReusableCellWithReuseIdentifier("chefPicCell", forIndexPath: indexPath) as! chefPicCell
            cell.chefBackground.image = selectedChef.images["background"]
            return cell
        } else if(indexPath.row == 1) {
            var cell: chefIntroductionCell = collectionView.dequeueReusableCellWithReuseIdentifier("chefProfileCell", forIndexPath: indexPath) as! chefIntroductionCell
            
            // set the height of the cell to recalculate size
            cell.chefIntroduction.text = selectedChef.description as? String
            cell.chefIntroduction.sizeToFit()
            cell.chefName.text = selectedChef.name as? String
            cell.chefAddr.text = (selectedChef.city as! String) + ", " + (selectedChef.province as! String)
            collectionView.collectionViewLayout.invalidateLayout()
            return cell
        } else if(indexPath.row == 2) {
            let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("separatorCell", forIndexPath: indexPath) as! UICollectionViewCell
            return cell
        } else {
            var cell: ingrdientCell = collectionView.dequeueReusableCellWithReuseIdentifier("ingrdientCell", forIndexPath: indexPath) as! ingrdientCell
            cell.ingrdientDetailLabel.text = selectChefItems[indexPath.row - 3].description
            cell.ingrdientDetailLabel.sizeToFit()
            cell.ingrdientNameLabel.text = selectChefItems[indexPath.row - 3].name
            cell.ingrdientPrice.text = "$"+selectChefItems[indexPath.row - 3].price.stringValue
            collectionView.collectionViewLayout.invalidateLayout()
            return cell
        }
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectChefItems.count + 3
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
            var cell = collectionView.cellForItemAtIndexPath(indexPath) as? chefIntroductionCell
            if( cell == nil){
                return CGSizeMake(collectionView.bounds.width*0.95, collectionView.bounds.height * 0.0874)
            } else {
                return CGSizeMake(collectionView.bounds.width*0.95, cell!.chefName.frame.height + cell!.chefIntroduction.frame.height + 26)
            }
        } else if(indexPath.row == 2) {
            return CGSizeMake(collectionView.bounds.width*0.95, collectionView.bounds.height * 0.0575)
        } else {
            var cell = collectionView.cellForItemAtIndexPath(indexPath) as? ingrdientCell
            if( cell == nil){
                return CGSizeMake(collectionView.bounds.width*0.95, collectionView.bounds.height * 0.1874)
            } else {
                return CGSizeMake(collectionView.bounds.width*0.95, cell!.ingrdientDetailLabel.frame.height + 40)
            }
            
        }
    }

}

extension UILabel {
    func resizeHeightToFit(heightConstraint: NSLayoutConstraint) {
        let attributes = [NSFontAttributeName : font]
        numberOfLines = 0
        lineBreakMode = NSLineBreakMode.ByWordWrapping
        let rect = self.text!.boundingRectWithSize(CGSizeMake(frame.size.width, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
        heightConstraint.constant = rect.height
        setNeedsLayout()
    }
}

