//
//  OrderRestaurantCell.swift
//  nummy_dev_client_ios
//
//  Created by Ralph Wang on 2015-06-28.
//  Copyright (c) 2015 omittech. All rights reserved.
//

import UIKit

class OrderRestaurantCell: UITableViewCell {
    
    @IBOutlet var restaurantPic: UIImageView!
    
    @IBOutlet var restaurantName: UILabel!
    
    @IBOutlet var status: UILabel!
    
    @IBOutlet var joinInTime: UILabel!
    
    @IBOutlet var userName: UILabel!
    
    @IBOutlet var userTel: UILabel!
    
    @IBOutlet var userAddr: UILabel!
    
    @IBOutlet var joiningFee: UILabel!
    
    @IBOutlet var HST: UILabel!
    
    @IBOutlet var total: UILabel!
    
}