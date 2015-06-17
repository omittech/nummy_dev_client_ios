//
//  ChefListNavigationView.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/6/15.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import UIKit

class ChefListNavigationView: ENSideMenuNavigationController, ENSideMenuDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: MyNavigationTableViewController(), menuPosition:.Left)
        //sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = 180.0 // optional, default is 160
        sideMenu?.menuHeight = 603
        //sideMenu?.bouncingEnabled = false
        
        // make navigation bar showing over side menu
//        view.bringSubviewToFront(navigationBar)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}
