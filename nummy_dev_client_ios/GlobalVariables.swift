//
//  GlobalVariables.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/6/20.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// should avoid using these variables
var shoppingCartVO = ShoppingCartVO()
var selectedChef: ChefVO!
var selectChefItems: [ItemVO] = [ItemVO]()
var selectedOrder: OrderVO!
let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext!) as! User

//struct GlobalVariables{
//    static var selectedChef: ChefVO! = ChefVO(dictionary: NSDictionary())
//}

let baseUrl = "http://dry-mountain-2007.herokuapp.com"
let userCoordinateLatitude = "userCoordinateLatitude"
let userCoordinateLongitude = "userCoordinateLongitude"
let lastStoryBoard = "lastStoryBoard"
let lastViewController = "lastViewController"

var testVC:UIViewController?

extension Double {
    func format(f: String) -> String {
        return NSString(format: "%\(f)f", self) as String
    }
}