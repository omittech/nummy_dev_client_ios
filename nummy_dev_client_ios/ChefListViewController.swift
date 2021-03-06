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

class ChefListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate, ENSideMenuDelegate{
    // record the number of cells in collection view(not including
    var numOfCell = 0
    var chefsList: [ChefVO] = [ChefVO]()
    var locationManager = CLLocationManager()

    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var chefList: UICollectionView!
    
    @IBAction func toggleSideMenu(sender: AnyObject) {
        toggleSideMenuView()
    }
    
    // show shopping cart page when clicked
    @IBAction func goToCart(sender: AnyObject) {
        var storyboard = UIStoryboard(name: "order", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("shoppingCart") as! UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("chefs", forKey: lastStoryBoard)
        defaults.setObject("chefList", forKey: lastViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        testVC = self
        self.sideMenuController()?.sideMenu?.delegate = self

        let chefListBackground: UIImageView = UIImageView(image: UIImage(named: "loginbg.png"))
        chefListBackground.alpha = 0.5
        chefList.backgroundView = chefListBackground
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // re-initialize the selected data
        selectChefItems = [ItemVO]()
        
        spinner.startAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        getChefs()
        spinner.stopAnimating()
        collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getChefs() {
        var apiEndpoint = baseUrl + "/api/restaurant/25.044898/121.523374/10"
        var urlRequest = NSMutableURLRequest(URL: NSURL(string: apiEndpoint)!)
        
        var getChefError: NSError?
        var responseData: NSData!
        responseData = NSURLConnection.sendSynchronousRequest(urlRequest, returningResponse: nil, error: &getChefError)
        var parseError: NSError?
        let parsedData = NSJSONSerialization.JSONObjectWithData(responseData, options: nil, error: &parseError) as! NSDictionary
        
        var chefs = parsedData.valueForKey("data") as! NSArray
        for chef in chefs {
            var chefVO = ChefVO(dictionary: chef as! NSDictionary)
            chefsList.append(chefVO)
        }
        numOfCell = chefsList.count
    }
    
    // Define cells
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: chefLocationCell = collectionView.dequeueReusableCellWithReuseIdentifier("chefCell", forIndexPath: indexPath) as! chefLocationCell
        var chefVO = chefsList[indexPath.row]
            
        // initiailize the content of a cell
        cell.chefName.text = chefVO.name as String
        cell.chefDistance.text = chefVO.distance.stringValue + " km"
        cell.chefAddress.text = (chefVO.address as String) + ", " + (chefVO.city as String)
        cell.chefPic.image = chefVO.images["chef"]
        return cell
    }
    
    // Define cell sizes
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var numOfCellsInPage = 7
//        var cellHeight = collectionView.bounds.size.height / CGFloat(numOfCellsInPage)
//        var cellHeight = 66.0
        var cellWidth = collectionView.bounds.size.width - 10
        return CGSizeMake(cellWidth, 73)
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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

    }
    
    // Controll the location update of user
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation: CLLocation = locations[0] as! CLLocation
        var latitude = userLocation.coordinate.latitude
        var longitude = userLocation.coordinate.longitude
        
        // store the coordinate locally
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(latitude.description, forKey: userCoordinateLatitude)
        defaults.setObject(longitude.description, forKey: userCoordinateLongitude)
        
        locationManager.stopUpdatingLocation()
    }
    
    // Pass the select chef infomation to next view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showChefDetail" {
            var indexPath: NSIndexPath = self.collectionView!.indexPathForCell(sender as! UICollectionViewCell)!
            let chefDetailView = segue.destinationViewController as! ChefDetailViewController
            selectedChef = chefsList[indexPath.row]
//            chefDetailView.chefVO = chefsList[indexPath.row]
            hideSideMenuView()
        }
    }
    
    // when click on other area, hide the side menu
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        hideSideMenuView()
    }
    
    func sideMenuWillOpen() {
        // ignore any click on collection view
        collectionView.userInteractionEnabled = false
    }
    
    func sideMenuWillClose() {
        // resume to accept user click on collection view
        collectionView.userInteractionEnabled = true
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        return true
    }
}


