//
//  ShoppingCartViewController.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/6/17.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import Foundation
import UIKit

class ShoppingCartViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    //***** Outlets **************
    @IBOutlet weak var restaurantList: UITableView!
    
    //****************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            var cell = restaurantList.dequeueReusableCellWithIdentifier("cartRestaurantCell") as! CartRestaurantCell
            return cell
        } else if indexPath.row == 1 {
            var cell = restaurantList.dequeueReusableCellWithIdentifier("cartItemCell") as! CartItemCell
            return cell
        } else {
            var cell = restaurantList.dequeueReusableCellWithIdentifier("cartPriceCell") as! CartPriceCell
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 85.0
        } else {
            return 80
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}