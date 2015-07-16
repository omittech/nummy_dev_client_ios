//
//  SuccessPageViewController.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/7/15.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import Foundation
import UIKit

class SuccessPageViewController: UIViewController {
    
    @IBAction func goToHome(sender: AnyObject) {
        var storyboard = UIStoryboard(name: "chefs", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("chefNavigationView") as! UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
}
