//
//  summaryController.swift
//  nummy_dev_client_ios
//
//  Created by Ralph Wang on 2015-06-18.
//  Copyright (c) 2015 omittech. All rights reserved.
//

import UIKit


class SummaryViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ENSideMenuDelegate {
    
    @IBOutlet var orderList: UICollectionView!
    var numOfCell = 0
    var ordersList: [OrderVO] = [OrderVO]()
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("spinner start")
        spinner.startAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        getOrders()
        spinner.stopAnimating()
        println("spinner end")
        orderList.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getOrders() {
        var apiEndpoint = baseUrl + "/api/order/user/553c561084bbed2b06474782"
        var urlRequest = NSMutableURLRequest(URL: NSURL(string: apiEndpoint)!)
        
        var getOrderError: NSError?
        var responseData: NSData!
        responseData = NSURLConnection.sendSynchronousRequest(urlRequest, returningResponse: nil, error: &getOrderError)
        var parseError: NSError?
        let parsedData = NSJSONSerialization.JSONObjectWithData(responseData, options: nil, error: &parseError) as! NSDictionary
        
        var orders = parsedData.valueForKey("data") as! NSArray
        for order in orders {
            var orderVO = OrderVO(dictionary: order as! NSDictionary)
            ordersList.append(orderVO)
        }
        numOfCell = ordersList.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //println("321")
        let cell: OrderCell = collectionView.dequeueReusableCellWithReuseIdentifier("orderCell", forIndexPath: indexPath) as! OrderCell
        
        var orderVO = ordersList[indexPath.row]
        
        cell.chefName.text = "Chef Miranda Kerr"
        cell.chefPic.image = UIImage(named: "chefPic.png")
        cell.orderTime.text = orderVO.createDate as String
        cell.pickupTime.text = "2014/12/15 14:00-15:00"
        cell.total.text = "$ " + orderVO.total.stringValue
        cell.status.text = orderVO.status as String
        cell.items.text! = String(orderVO.itemsCount) + " items (" + orderVO.items[0].name + "...)" as String
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //println("321")
        return numOfCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        return CGSize(width:screenSize.width*0.95,height:150)
    }
    
    /*func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        var edgeInset: UIEdgeInsets = UIEdgeInsetsMake(CGFloat(0), CGFloat(-10), CGFloat(0), CGFloat(-10))
        return edgeInset
    }*/
    
    
    @IBAction func showCart(sender: AnyObject) {
        var storyboard = UIStoryboard(name: "order", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("shoppingCart") as! UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("summary", forKey: lastStoryBoard)
        defaults.setObject("summaryPage", forKey: lastViewController)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showOrderDetails" {
            var senderCell = sender as! OrderCell
            var indexPath: NSIndexPath = self.orderList.indexPathForCell(senderCell)!
            selectedOrder = ordersList[indexPath.row]
            //println(selectedOrder.id as String)
        }
    }
}