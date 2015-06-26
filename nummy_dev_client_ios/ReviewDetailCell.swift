//
//  ReviewDetailCell.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/6/22.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import Foundation
import UIKit

class ReviewDetailCell: UITableViewCell {
    
    @IBOutlet weak var joinInTimeButton: UIButton!
//    @IBOutlet weak var joinInTimeSelection: UIPickerView!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var joiningFee: UILabel!
    @IBOutlet weak var tax: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
}