//
//  OrderVO.swift
//  nummy_dev_client_ios
//
//  Created by Ralph Wang on 2015-06-23.
//  Copyright (c) 2015 omittech. All rights reserved.
//

import Foundation
import UIKit

struct OrderVO {
    var id: NSString = ""
    var userId: NSString = ""
    var restaurantId: NSString = ""
    var subtotal: NSNumber = 0
    var tax: NSNumber = 0
    var total: NSNumber = 0
    var status: NSString = ""
    var updateDate: NSString = ""
    var createDate: NSString = ""
    var isDelete: Bool = false
    var note: NSString = ""
    var items: [ItemVO] = [ItemVO]()
    var itemsCount: Int = 0

    init(dictionary: NSDictionary) {
        self.id = dictionary.valueForKey("_id") as! NSString
        self.userId = dictionary.valueForKey("userId") as! NSString
        self.restaurantId = dictionary.valueForKey("restaurantId") as! NSString
        self.subtotal = dictionary.valueForKey("subtotal") as! NSNumber
        self.tax = dictionary.valueForKey("tax") as! NSNumber
        self.total = dictionary.valueForKey("total") as! NSNumber
        self.status = dictionary.valueForKey("status") as! NSString
        self.updateDate = dictionary.valueForKey("updateDate") as! NSString
        self.createDate = dictionary.valueForKey("createDate") as! NSString
        self.isDelete = dictionary.valueForKey("isDelete") as! Bool
        self.note = dictionary.valueForKey("note") as! NSString
        
        var itemList = dictionary.valueForKey("items") as! NSArray
        
        for item in itemList {
            var itemVO = ItemVO(dictionary: item as! NSDictionary)
            items.append(itemVO)
            itemsCount++
            //println(itemVO.name)
        }
    }
}