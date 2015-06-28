//
//  GlobalVariables.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/6/20.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import Foundation
import UIKit

// should avoid using these variables
var selectedChef: ChefVO!
var selectChefItems: [ItemVO] = [ItemVO]()
//struct GlobalVariables{
//    static var selectedChef: ChefVO! = ChefVO(dictionary: NSDictionary())
//}

let baseUrl = "http://dry-mountain-2007.herokuapp.com"
let userCoordinateLatitude = "userCoordinateLatitude"
let userCoordinateLongitude = "userCoordinateLongitude"
let lastStoryBoard = "lastStoryBoard"
let lastViewController = "lastViewController"