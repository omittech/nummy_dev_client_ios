//
//  ViewController.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/4/20.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import UIKit

class ChefDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var chefVO: ChefVO!
    var itemsList: [ItemVO] = [ItemVO]()
    var numOfCell = 0
    
    @IBOutlet weak var chefPicture: UIImageView!
    @IBOutlet weak var chefName: UILabel!
    @IBOutlet weak var chefAddress: UILabel!
    @IBOutlet weak var chefDistance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chefPicture.image = chefVO.images["chef"]
        chefName.text = chefVO.name as String
        chefAddress.text = chefVO.address as String
        chefDistance.text = chefVO.distance.stringValue + " km"
        
        getItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getItems() {
        var apiEndpoint = baseUrl + "/api/item/restaurant/" + (chefVO.id as String)
        var urlRequest = NSMutableURLRequest(URL: NSURL(string: apiEndpoint)!)
        
        var getChefError: NSError?
        var responseData: NSData!
        responseData = NSURLConnection.sendSynchronousRequest(urlRequest, returningResponse: nil, error: &getChefError)
        var parseError: NSError?
        let parsedData = NSJSONSerialization.JSONObjectWithData(responseData, options: nil, error: &parseError) as! NSDictionary
        
        var items = parsedData.valueForKey("data") as! NSArray
        for item in items {
            var itemVO = ItemVO(dictionary: item as! NSDictionary)
            itemsList.append(itemVO)
        }
        numOfCell = itemsList.count
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numOfCell
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell: foodItemCell = collectionView.dequeueReusableCellWithReuseIdentifier("chefItemCell", forIndexPath: indexPath) as! foodItemCell
        var item = itemsList[indexPath.row]
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
}

