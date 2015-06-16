//
//  TermAndConditionsViewController.swift
//  nummy_dev_client_ios
//
//  Created by Ralph Wang on 2015-04-29.
//  Copyright (c) 2015 omittech. All rights reserved.
//

import UIKit

class TermAndConditionsViewController: UIViewController {
    
    @IBAction func backToLogin(sender: AnyObject) {
        
        performSegueWithIdentifier("T&CbackLoginSegue", sender: self)
        
    }
    @IBAction func realLogin(sender: AnyObject) {
        
        var storyboard = UIStoryboard(name: "chefs", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("chefNavigationView") as! UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}