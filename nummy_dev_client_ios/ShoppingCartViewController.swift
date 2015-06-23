//
//  ShoppingCartViewController.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/6/17.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import Foundation
import UIKit

var shoppingCartVO = ShoppingCartVO()

// Use this cell to record data for each table view cell
// It holds data for restaurant, item and price
enum FlattenCellType {
    case CHEF
    case ITEM
    case PRICE
}
struct FlattenCell {
    // used to indicate what type of data is recorded in this cell
    
    var type: FlattenCellType?
    // data for restaurant
    var restaurantPicture: UIImage?
    var restaurantName: String?
    var address: String?
    
    // data for item
    var name: String?
    var price: Double?
    var quantity: Int?
    
    //data for price
    var transportationFee: String?
    var tax: String?
    var total: String?
}

class ShoppingCartViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var restaurantList: UITableView!
    
    var cellsForDisplay:[FlattenCell] = [FlattenCell]()
    
    @IBAction func goToLastPage(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        var lastBoard = defaults.objectForKey(lastStoryBoard) as! String
        var lastController = defaults.objectForKey(lastViewController) as! String
        
        var storyboard = UIStoryboard(name: lastBoard, bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier(lastController) as! UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // flatten the items in shopping cart into flatten cell, which helps for displaying
        for chefId in shoppingCartVO.chefIds {
            var chef = shoppingCartVO.chefs[chefId]!
            var chefCell = FlattenCell()
            chefCell.type = FlattenCellType.CHEF
            chefCell.restaurantPicture = chef.images["chef"]
            chefCell.restaurantName = chef.name as String
            chefCell.address = chef.address as String
            cellsForDisplay.append(chefCell)
            
            var totalCharge = 0.0
            for itemId in shoppingCartVO.itemIds {
                var item = shoppingCartVO.items[itemId]!
                var itemCell = FlattenCell()
                itemCell.type = FlattenCellType.ITEM
                itemCell.name = item.name
                itemCell.price = Double(item.price)
                itemCell.quantity = item.quantity
                totalCharge = totalCharge + Double(item.price)
                
                cellsForDisplay.append(itemCell)
            }
            
            var priceCell = FlattenCell()
            priceCell.type = FlattenCellType.PRICE
            priceCell.transportationFee = "$0"
            priceCell.tax = "$0"
            priceCell.total = "$" + totalCharge.description
            cellsForDisplay.append(priceCell)
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var flattenCell = cellsForDisplay[indexPath.row]
        var type = flattenCell.type
        if type == FlattenCellType.CHEF {
            var cell = restaurantList.dequeueReusableCellWithIdentifier("cartRestaurantCell") as! CartRestaurantCell
            cell.restaurantPicture.image = flattenCell.restaurantPicture
            cell.restaurantName.text = flattenCell.restaurantName
            cell.address.text = flattenCell.address
            return cell
        } else if type == FlattenCellType.ITEM {
            var cell = restaurantList.dequeueReusableCellWithIdentifier("cartItemCell") as! CartItemCell
            cell.name.text = flattenCell.name
            cell.price.text = "$" + flattenCell.price!.description
            cell.quantity.text = flattenCell.quantity?.description
            return cell
        } else {
            var cell = restaurantList.dequeueReusableCellWithIdentifier("cartPriceCell") as! CartPriceCell
            cell.transportationFee.text = flattenCell.transportationFee
            cell.tax.text = flattenCell.tax
            cell.total.text = flattenCell.total
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var type = cellsForDisplay[indexPath.row].type
        if type == FlattenCellType.ITEM {
            return 85.0
        } else {
            return 80
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsForDisplay.count
    }
}