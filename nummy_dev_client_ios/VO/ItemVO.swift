//
//  ItemVO.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/6/9.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import Foundation

struct ItemVO {
    var id: String = ""
    var name: String = ""
    var restaurantId: String = ""
    var image: UIImage
    var price: NSNumber = 0
    var description: String = ""
    var isDelete: Bool = true
    var isHot: Bool = true
    var popularity: NSNumber = 0
    var quantity:Int = 0
    
    init(dictionary : NSDictionary) {
        self.id = dictionary.valueForKey("_id") as! String
        self.name = dictionary.valueForKey("name") as! String
        self.restaurantId = dictionary.valueForKey("restaurantId") as! String
        self.price = dictionary.valueForKey("price") as! NSNumber
        self.description = dictionary.valueForKey("description") as! String
        self.popularity = dictionary.valueForKey("popularity") as! NSNumber
        self.description = dictionary.valueForKey("description") as! String
        self.isDelete = dictionary.valueForKey("isDelete") as! Bool
        self.isHot = dictionary.valueForKey("isHot") as! Bool
        
        // get item image
        let url = NSURL(string: (baseUrl as String) + "/api/images/" + (dictionary.valueForKey("image") as! String))
        let data = NSData(contentsOfURL: url!)
        image = UIImage(data: data!)!
    }
}