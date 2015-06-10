//
//  chefVO.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/6/7.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import Foundation
import UIKit

struct ChefVO  {
    var id: NSString = ""
    var name: NSString = ""
    var country: NSString = ""
    var province: NSString = ""
    var city: NSString = ""
    var address: NSString = ""
    var postcode: NSString = ""
    var description: NSString = ""
    var updateDate: NSString = ""
    var createDate: NSString = ""
    var distance: NSNumber = 0
    var isActive: Bool = true
    var isPublic: Bool = true
    var images: Dictionary<String, UIImage> = Dictionary<String, UIImage>()
    //    var location: [Double] = [Double]()
    
    init(dictionary : NSDictionary) {
        self.id = dictionary.valueForKey("_id") as! NSString
        self.name = dictionary.valueForKey("name") as! NSString
        self.country = dictionary.valueForKey("country") as! NSString
        self.province = dictionary.valueForKey("province") as! NSString
        self.city = dictionary.valueForKey("city") as! NSString
        self.address = dictionary.valueForKey("address") as! NSString
        self.postcode = dictionary.valueForKey("postcode") as! NSString
        self.description = dictionary.valueForKey("description") as! NSString
        self.updateDate = dictionary.valueForKey("updateDate") as! NSString
        self.createDate = dictionary.valueForKey("createDate") as! NSString
        self.isActive = dictionary.valueForKey("isActive") as! Bool
        self.isPublic = dictionary.valueForKey("isPublic") as! Bool
        self.distance = dictionary.valueForKey("distanceTouser") as! NSNumber
        //        self.location = dictionary.valueForKey("_id") as! [Double]
        var imagePaths = dictionary.valueForKey("images") as! [String]
        
        // get the images for chef
        let url1 = NSURL(string: (baseUrl as String) + "/api/images/" + imagePaths[0])
        let data1 = NSData(contentsOfURL: url1!)
        let url2 = NSURL(string: (baseUrl as String) + "/api/images/" + imagePaths[1])
        let data2 = NSData(contentsOfURL: url2!)
        if NSString(string: imagePaths[0]).containsString("chef") {
            images["chef"] = UIImage(data: data1!)
            images["background"] = UIImage(data: data2!)
        } else {
            images["background"] = UIImage(data: data1!)
            images["chef"] = UIImage(data: data2!)
        }

        
        
    }
}


