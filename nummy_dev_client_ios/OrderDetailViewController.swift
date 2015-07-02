//
//  OrderDetailViewController.swift
//  nummy_dev_client_ios
//
//  Created by Ralph Wang on 2015-06-26.
//  Copyright (c) 2015 omittech. All rights reserved.
//

import Foundation


class OrderDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var itemsFromOrder = [ItemVO]()
    var orderId: String?
    
    @IBOutlet var orderDetailList: UITableView!
    
    
    override func viewDidLoad() {
        orderDetailList.allowsSelection = false
        //println(String(selectedOrder.itemsCount))
        for (var itemId=0; itemId < selectedOrder.itemsCount; itemId++) {
            var item: ItemVO = selectedOrder.items[itemId]
                itemsFromOrder.append(item)
        }
        //println(String(itemsFromOrder.count))
        orderDetailList.dataSource = self
        orderDetailList.delegate = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println(String(itemsFromOrder.count+1))
        return itemsFromOrder.count + 1
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //println(String(indexPath.row))
        if indexPath.row == 0 {
            let cell: OrderRestaurantCell = orderDetailList.dequeueReusableCellWithIdentifier("orderInfoCell", forIndexPath: indexPath) as! OrderRestaurantCell
            cell.restaurantPic.image = UIImage(named: "chefPic.png")
            cell.restaurantName.text = "Chef Miranda Kerr"
            cell.status.text = selectedOrder.status as String
            cell.joinInTime.text = "johnInTime"
            cell.userName.text = selectedOrder.userId as String
            cell.userTel.text = "123456789"
            cell.userAddr.text = "23 Hollywood Ave."
            cell.joiningFee.text = "$ " + "4.99"
            cell.HST.text! = "$ " + selectedOrder.tax.stringValue
            cell.total.text! = "$ " + selectedOrder.total.stringValue
            println("111")
            return cell
        } else {
            let cell: OrderItemCell = orderDetailList.dequeueReusableCellWithIdentifier("ItemInfoCell", forIndexPath: indexPath) as! OrderItemCell
            var item = selectedOrder.items[indexPath.row-1]
            cell.itemImage.image = UIImage(named: "chefPic.png")
            cell.itemName.text = item.name
            cell.itemPrice.text = item.price.stringValue
            cell.itemQuantity.text = String(item.quantity)
            println("222")
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 325
        } else {
            return 75
        }
    }
    
    @IBAction func getBack(sender: AnyObject) {
        performSegueWithIdentifier("getBack", sender: self)
    }
    

    
    @IBAction func deleteOrder(sender: AnyObject) {
        println("order Deleted")
        selectedOrder.isDelete = true
        
    }
    
    
    
    
}