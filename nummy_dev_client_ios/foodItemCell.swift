//
//  foodItemCell.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/5/30.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import UIKit

class foodItemCell : UICollectionViewCell{
    
    @IBOutlet weak var addItemButton: UIButton!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var numOfLike: UILabel!
    @IBOutlet weak var likeButton: UIImageView!
    @IBOutlet weak var itemImage: UIImageView!
}