//
//  ViewController.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/4/20.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ChefListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate{
    // record the number of cells in collection view(not including
    var numOfItem = 0
    var numOfCell = 11
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // next page button is clicked
    @IBAction func nextPage(sender: AnyObject) {
        println(sender.tag)
        var indexPath: NSIndexPath = self.collectionView.indexPathForItemAtPoint(self.collectionView.convertPoint(sender.center, fromView: sender.superview))!
        var myIndexPath:NSIndexPath = NSIndexPath(forRow: indexPath.row+6, inSection: 0)
        if(sender.tag < numOfCell - 1) {
            self.collectionView.scrollToItemAtIndexPath(myIndexPath, atScrollPosition: UICollectionViewScrollPosition.Bottom, animated: true)
        }
    }
    
    @IBAction func lastPage(sender: AnyObject) {
        var row = -sender.tag
        var indexPath: NSIndexPath = self.collectionView.indexPathForItemAtPoint(self.collectionView.convertPoint(sender.center, fromView: sender.superview))!
        var myIndexPath:NSIndexPath = NSIndexPath(forRow: indexPath.row-6, inSection: 0)
        if(row > 5) {
            self.collectionView.scrollToItemAtIndexPath(myIndexPath, atScrollPosition: UICollectionViewScrollPosition.Bottom, animated: true)
        }
    }
    @IBOutlet weak var chefList: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chefListBackground: UIImageView = UIImageView(image: UIImage(named: "loginbg.png"))
        chefListBackground.alpha = 0.5
        chefList.backgroundView = chefListBackground
        
        self.collectionView.scrollEnabled = false
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidAppear(animated: Bool) {
        var indexPath = NSIndexPath(forRow: 5, inSection: 0)
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.Bottom, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getChefs() {
        var apiEndpoint = "http://afternoon-springs-1132.herokuapp.com/api/user"
        var urlRequest = NSMutableURLRequest(URL: NSURL(string: apiEndpoint)!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue(), completionHandler:{
            (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if let anError = error
            {
                // got an error in getting the data, need to handle it
                println("error calling GET on /posts/1")
            }
            else // no error returned by URL request
            {
                // parse the result as json, since that's what the API provides
                var jsonError: NSError?
                let post = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary
                if let aJSONError = jsonError
                {
                    // got an error while parsing the data, need to handle it
                    println("error parsing /posts/1")
                }
                else
                {
                    var users: NSArray = post["data"] as! NSArray
                    println(users[0]["createDate"])
                    // now we have the post, let's just print it to prove we can access it
//                    println("The post is: " + post.description)
                    
                    // the post object is a dictionary
                    // so we just access the title using the "title" key
                    // so check for a title and print it if we have one
//                    if var postTitle = post["title"] as? String
//                    {
//                        println("The title is: " + postTitle)
//                    }
                }
            }
        })
    }
    
    // Define cells
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(indexPath.row % 6 == 5) {
            let cell: chelListNextPageCell = collectionView.dequeueReusableCellWithReuseIdentifier("nextPageCell", forIndexPath: indexPath) as! chelListNextPageCell
            cell.nextPageButton.tag = indexPath.row
            cell.lastPageButton.tag = -indexPath.row
            // disable "lastPageButton" for the first page
            if(indexPath.row == 5) {
                cell.lastPageButton.hidden = true
                cell.nextPageButton.hidden = false
            } else if(indexPath.row == numOfCell - 1 ){
                cell.nextPageButton.hidden = true
                cell.lastPageButton.hidden = false
            }
            return cell
        } else if(indexPath.row >= numOfItem && indexPath.row < collectionView.numberOfItemsInSection(0)-1){
            let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("emptyCell", forIndexPath: indexPath) as! UICollectionViewCell
            return cell
        } else {
            let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("chefCell", forIndexPath: indexPath) as! UICollectionViewCell
            return cell
        }
    }
    
    // Define cell sizes
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var numOfCellsInPage = 7
        var cellHeight = collectionView.bounds.size.height / CGFloat(numOfCellsInPage)
        var cellWidth = collectionView.bounds.size.width - 10
        return CGSizeMake(cellWidth, cellHeight)
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numOfPage: NSInteger = numOfCell / 5
        if(numOfCell % 5 != 0) {
            numOfPage++
        }
        // add cell for nextPage button
        numOfCell += numOfPage
        numOfItem = numOfCell
        numOfCell = numOfCell+(6 - numOfCell%6)
        println("Number of cells: \(numOfCell)")
        return numOfCell
    }
    
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            let edgeInSets: UIEdgeInsets =  UIEdgeInsets(top: collectionView.bounds.size.height / 20, left: 0, bottom: 0, right: 0)
            return edgeInSets
    }
    
    
    func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
    }
    
    // Controll the location update of user
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation: CLLocation = locations[0] as! CLLocation
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        
        println("Latitude: \(latitude), Longitude: \(longitude)")
        
        locationManager.stopUpdatingLocation()
    }
    
}

