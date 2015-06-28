//
//  MyNavigationTableViewController.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/6/15.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import UIKit

class MyNavigationTableViewController: UITableViewController {
    var selectedMenuItem : Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
//        tableView.backgroundColor = UIColor.clearColor()

        var color = 0xEFBDA5
        tableView.backgroundColor = UIColor(
            red: CGFloat((color & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((color & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(color & 0x0000FF) / 255.0,
            alpha: CGFloat(0.5)
        )
        tableView.scrollsToTop = false
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL") as? UITableViewCell
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clearColor()
            cell!.textLabel?.textColor = UIColor.darkGrayColor()
            let selectedBackgroundView = UIView(frame: CGRectMake(0, 0, cell!.frame.size.width, cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
        }
        
        switch (indexPath.row) {
        case 0:
            var menuImage = UIImage(named: "bigNummy.png")
            var subview = UIImageView(frame: CGRectMake(30, 10, 130, 150))
            subview.image = menuImage
            cell!.addSubview(subview)
            break
        case 1:
            var menuLabel = UILabel(frame: CGRectMake(50, -7, 100, 70))
            menuLabel.attributedText = NSAttributedString(string: "Home", attributes: [NSForegroundColorAttributeName:UIColor.darkGrayColor()])
            
            var menuImage = UIImage(named: "home.png")
            var subview = UIImageView(frame: CGRectMake(15, 10, 30, 30))
            subview.image = menuImage
            cell!.addSubview(menuLabel)
            cell!.addSubview(subview)

            break
        case 2:
            var menuLabel = UILabel(frame: CGRectMake(50, -7, 200, 70))
            menuLabel.attributedText = NSAttributedString(string: "Shopping Cart", attributes: [NSForegroundColorAttributeName:UIColor.darkGrayColor()])
            
            var menuImage = UIImage(named: "shoppingcart.png")
            var subview = UIImageView(frame: CGRectMake(15, 10, 30, 30))
            subview.image = menuImage
            cell!.addSubview(menuLabel)
            cell!.addSubview(subview)
            break
        case 3:
            var menuLabel = UILabel(frame: CGRectMake(50, -7, 200, 70))
            menuLabel.attributedText = NSAttributedString(string: "Summary", attributes: [NSForegroundColorAttributeName:UIColor.darkGrayColor()])
            
            var menuImage = UIImage(named: "summary.png")
            var subview = UIImageView(frame: CGRectMake(15, 13, 30, 30))
            subview.image = menuImage
            cell!.addSubview(menuLabel)
            cell!.addSubview(subview)
            break
        default:
            var menuLabel = UILabel(frame: CGRectMake(50, -7, 200, 70))
            menuLabel.attributedText = NSAttributedString(string: "My Account", attributes: [NSForegroundColorAttributeName:UIColor.darkGrayColor()])
            
            var menuImage = UIImage(named: "account.png")
            var subview = UIImageView(frame: CGRectMake(15, 13, 30, 30))
            subview.image = menuImage
            cell!.addSubview(menuLabel)
            cell!.addSubview(subview)
            break
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200.0
        } else {
            return 50.0
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("did select row: \(indexPath.row)")

        
        if (indexPath.row == selectedMenuItem) {
                    println("did select row: \(indexPath.row)")
            hideSideMenuView()
            return
        }
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        switch (indexPath.row) {
        case 0:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController1") as! UIViewController
            break
        case 1:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController2")as! UIViewController
            break
        case 2:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController3")as! UIViewController
            break
        case 4:
            let loginStoryboard: UIStoryboard = UIStoryboard(name: "login",bundle: nil)
            destViewController = loginStoryboard.instantiateViewControllerWithIdentifier("myAccount") as! UIViewController
            break
        default:
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ViewController4") as! UIViewController
            break
        }

        testVC!.presentViewController(destViewController, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
