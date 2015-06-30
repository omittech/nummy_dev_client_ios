//
//  OrderDetailViewController.swift
//  nummy_dev_client_ios
//
//  Created by Ralph Wang on 2015-06-26.
//  Copyright (c) 2015 omittech. All rights reserved.
//

import Foundation


class OrderDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var itemsFromChef = [ItemVO]()
    var orderId: String?
    
    @IBOutlet var orderDetailList: UITableView!
    
    @IBAction func cancelOder(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        orderDetailList.allowsSelection = false
        
        for itemId in shoppingCartVO.itemIds {
            var item = shoppingCartVO.items[itemId]!
            if item.restaurantId == chefId {
                itemsFromChef.append(item)
            }
        }
    }
    
    
    
    
    
    
    
    
    
}