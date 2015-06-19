//
//  ShoppingCartVO.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/6/18.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import Foundation
import UIKit

struct ShoppingCartVO {
    // Ids for chef&item added to the shopping cart
    var chefIds:[String] = [String]()
    var itemIds:[String] = [String]()
    
    var chefs: [String:ChefVO] = [String:ChefVO]()
    var items: [String:ItemVO] = [String:ItemVO]()
}