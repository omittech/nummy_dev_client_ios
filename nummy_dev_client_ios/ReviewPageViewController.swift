//
//  ReviewPageViewController.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/6/22.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import Foundation
import UIKit

class ReviewPageViewController : UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var reviewList: UITableView!
    @IBOutlet weak var joinInTimePicker: UIPickerView!
    @IBOutlet weak var joinInTimeButton: UIButton!
    @IBOutlet weak var selectionBackground: UIView!
    
    var joinInTimeChoices = ["12/15, 2:00PM-2:30PM", "12/15, 3:00PM-3:30PM", "12/15, 4:00PM-4:30PM", "12/15, 5:00PM-5:30PM"]
    var chefId: String?
    var itemsFromChef = [ItemVO]()
    
    override func viewDidLoad() {
        reviewList.allowsSelection = false
        
        for itemId in shoppingCartVO.itemIds {
            var item = shoppingCartVO.items[itemId]!
            if item.restaurantId == chefId {
                itemsFromChef.append(item)
            }
        }
    }
    
    @IBAction func join(sender: AnyObject) {
        var postsEndpoint: String = baseUrl + "/api/order"
        var postsUrlRequest = NSMutableURLRequest(URL: NSURL(string: postsEndpoint)!)
        postsUrlRequest.HTTPMethod = "POST"
        
        var newPost: NSDictionary = ["userId": "553c561084bbed2b06474782", "restaurantId": "553d9872377d103c055f66b1", "subtotal":36.8, "tax":3.4, "total":40.2,
        "note":"", "items":[]];
        var postJSONError: NSError?
        var jsonPost = NSJSONSerialization.dataWithJSONObject(newPost, options: nil, error:  &postJSONError)
        postsUrlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        postsUrlRequest.HTTPBody = jsonPost
        
        var data: NSData!
        data = NSURLConnection.sendSynchronousRequest(postsUrlRequest, returningResponse: nil, error: &postJSONError)
        var jsonError: NSError?
        let post = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary
        let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError)
        if let unwrappedError = jsonError {
            println("json error: \(unwrappedError)")
        } else {
            println("The post is:" + post.description)
        }
        var status: NSString! = post.valueForKey("status") as! NSString
        if (status == "fail") {
            println("login failed")
        }

    }
    
    @IBAction func showTimeSelection(sender: AnyObject) {
        var oldFrame = selectionBackground.frame
        oldFrame.size.height = 150
        oldFrame.origin.y = oldFrame.origin.y - 150.0
        
        UIView.animateKeyframesWithDuration(0.7, delay: 0, options: .CalculationModeCubic, animations: {
        UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: {
            self.selectionBackground.frame = oldFrame
            })
            }, completion: { finished in
                println(self.joinInTimePicker.selectedRowInComponent(0))
                self.joinInTimePicker.hidden = false
        })
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        } else {
            return 85
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            var chefVO = shoppingCartVO.chefs[chefId!]!
            var cell = reviewList.dequeueReusableCellWithIdentifier("reviewDetailCell") as! ReviewDetailCell
            cell.userTitle.text = chefVO.name as String
            cell.userName.text = chefVO.name as String
            cell.phoneNumber.text = chefVO.phone
            cell.address.text = chefVO.address as String
            cell.area.text = "\(chefVO.postcode as String), \(chefVO.province as String), \(chefVO.country)"
            
            var price = 0.0
            for item in itemsFromChef {
                price = price + item.price.doubleValue
            }
            var tax = price * 0.13
            var total = price + tax
            cell.joiningFee.text = price.format(".2")
            cell.tax.text = tax.format(".2")
            cell.totalPrice.text = total.format(".2")
            return cell
        } else {
            var cell = reviewList.dequeueReusableCellWithIdentifier("reviewItemCell") as! CartItemCell
            var item = itemsFromChef[indexPath.row - 1]
            cell.name.text = item.name
            cell.price.text = "$\(item.price)"
            cell.quantity.text = item.quantity.description
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let count = itemsFromChef.count + 1
        return count
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return joinInTimeChoices.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return joinInTimeChoices[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var cell = reviewList.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! ReviewDetailCell
        cell.joinInTimeButton.titleLabel?.text = joinInTimeChoices[row]
        
        self.joinInTimePicker.hidden = true
        var oldFrame = selectionBackground.frame
        oldFrame.size.height = 1
        oldFrame.origin.y = oldFrame.origin.y + 150.0
        
        UIView.animateKeyframesWithDuration(0.7, delay: 0, options: .CalculationModeCubic, animations: {
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: {
                self.selectionBackground.frame = oldFrame
            })
            }, completion: { finished in
                
        })
    }

}