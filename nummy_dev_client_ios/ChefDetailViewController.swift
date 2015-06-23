//
//  ViewController.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/4/20.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import UIKit

class ChefDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var numOfCell = 0
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var chefPicture: UIImageView!
    @IBOutlet weak var chefName: UILabel!
    @IBOutlet weak var chefAddress: UILabel!
    @IBOutlet weak var chefDistance: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var chefTitle: UINavigationItem!
    
    // show shopping cart page when clicked
    @IBAction func goToCart(sender: AnyObject) {
        var storyboard = UIStoryboard(name: "order", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("shoppingCart") as! UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("chefs", forKey: lastStoryBoard)
        defaults.setObject("chefDetail", forKey: lastViewController)
    }

    // Add the item to shopping cart when click
    @IBAction func addToCart(sender: AnyObject) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! foodItemCell
        let indexPath = collectionView.indexPathForCell(cell)!
        let itemToAdd = selectChefItems[indexPath.row]
        
        // if restaurant haven't got any item in cart, add restaurant
        if(!contains(shoppingCartVO.chefIds, itemToAdd.restaurantId)) {
            shoppingCartVO.chefIds.append(selectedChef.id as String)
            shoppingCartVO.chefs[selectedChef.id as String] = selectedChef
        }
        
        // if item haven't got any item in cart, add item
        if(!contains(shoppingCartVO.itemIds, itemToAdd.id)) {
            shoppingCartVO.itemIds.append(itemToAdd.id)
            shoppingCartVO.items[itemToAdd.id] = itemToAdd
        }
        shoppingCartVO.items[itemToAdd.id]?.quantity++
        
        var cgframe = CGRectMake(200, -100, 50, 50)
        if(cell.subviews.count < 2) {
            var newimage = UIImageView(frame: cell.itemImage.frame)
            newimage.image = cell.itemImage.image
            cell.addSubview(newimage)
            
            UIView.animateKeyframesWithDuration(0.7, delay: 0, options: .CalculationModeCubic, animations: {
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: {
                    newimage.frame = cgframe
                })
                
                }, completion: nil)
        } else {
            var newimage = cell.subviews[1] as! UIImageView
            newimage.frame = cell.itemImage.frame
            UIView.animateKeyframesWithDuration(0.7, delay: 0, options: .CalculationModeCubic, animations: {
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: {
                    newimage.frame = cgframe
                })
                
                }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chefTitle.title = selectedChef.name as String
        chefPicture.image = selectedChef.images["chef"]
        chefName.text = selectedChef.name as String
        chefAddress.text = selectedChef.address as String
        chefDistance.text = selectedChef.distance.stringValue + " km"
        
        spinner.startAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        getItems()
        spinner.stopAnimating()
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getItems() {
        var apiEndpoint = baseUrl + "/api/item/restaurant/" + (selectedChef.id as String)
        var urlRequest = NSMutableURLRequest(URL: NSURL(string: apiEndpoint)!)
        
        var getChefError: NSError?
        var responseData: NSData!
        responseData = NSURLConnection.sendSynchronousRequest(urlRequest, returningResponse: nil, error: &getChefError)
        var parseError: NSError?
        let parsedData = NSJSONSerialization.JSONObjectWithData(responseData, options: nil, error: &parseError) as! NSDictionary
        
        var items = parsedData.valueForKey("data") as! NSArray
        selectChefItems.removeAll(keepCapacity: false)
        for item in items {
            var itemVO = ItemVO(dictionary: item as! NSDictionary)
            selectChefItems.append(itemVO)

        }
        numOfCell = selectChefItems.count
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfCell
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: foodItemCell = collectionView.dequeueReusableCellWithReuseIdentifier("chefItemCell", forIndexPath: indexPath) as! foodItemCell
        var item = selectChefItems[indexPath.row]
        cell.itemName.text = item.name
        cell.itemPrice.text = "$"+item.price.stringValue
        cell.itemImage.image = item.image
        return cell
    }
    
    
//    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
//        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
//            let edgeInSets: UIEdgeInsets =  UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 10)
//            return edgeInSets
//    }
    
    // Define cell sizes
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSizeMake(collectionView.bounds.width*0.485, collectionView.bounds.height*0.4924)
        
    }
    
    // Pass the select chef infomation to next view
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showChefIntroduction" {
//            let chefIntroductionView = segue.destinationViewController as! ChefIntroViewController
////            chefIntroductionView.chefVO = selectedChef
//            chefIntroductionView.itemsList = selectChefItems
//        }
//    }
}

