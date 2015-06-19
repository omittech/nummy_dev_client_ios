//
//  ForgetPasswordViewController.swift
//  nummy_dev_client_ios
//
//  Created by Ralph Wang on 2015-04-24.
//  Copyright (c) 2015 omittech. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func backToLogin(sender: AnyObject) {
        performSegueWithIdentifier("FPbackLoginSegue", sender: self)
        
    }
    
    @IBOutlet var email: UIButton!
    @IBOutlet var phone: UIButton!
    
    @IBAction func emailSelected(sender: UIButton) {

        sender.selected = !sender.selected;
        phone.selected = !phone.selected;
        
        if (sender.selected == true) {
            let image  = UIImage(named: "emailSelected.png")
            sender.setImage(image, forState: UIControlState.Selected)
        }

    
    }
    
    @IBAction func textSelected(sender: UIButton) {
        sender.selected = !sender.selected;
        email.selected = !email.selected;
        
        if (sender.selected == true) {
            let image  = UIImage(named: "textSelected.png")
            sender.setImage(image, forState: UIControlState.Selected)
        }
    
    }
    
    @IBOutlet var contactInfo: UITextField!
    
    
    @IBAction func sendPassword(sender: AnyObject) {
        
        var contact = contactInfo.text!
        
        //call send password email
        // MARK: POST
        // Create new post
        var postsEndpoint: String = "http://frozen-island-6927.herokuapp.com/sendPassword"  //not created yet
        var postsUrlRequest = NSMutableURLRequest(URL: NSURL(string: postsEndpoint)!)
        postsUrlRequest.HTTPMethod = "POST"
        
        var newPost: NSDictionary = ["contact": contact];
        var postJSONError: NSError?
        var jsonPost = NSJSONSerialization.dataWithJSONObject(newPost, options: nil, error:  &postJSONError)
        postsUrlRequest.HTTPBody = jsonPost
        
        NSURLConnection.sendAsynchronousRequest(postsUrlRequest, queue: NSOperationQueue(), completionHandler:{
            (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if let anError = error
            {
                // got an error in getting the data, need to handle it
                println("error calling POST on /(*)")
            }
            else
            {
                // parse the result as json, since that's what the API provides
                var jsonError: NSError?
                let post = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary
                if let aJSONError = jsonError
                {
                    // got an error while parsing the data, need to handle it
                    println("error parsing response from POST on /(*)")
                }
                else
                {
                    // we should get the post back, so print it to make sure all the fields are as we set to and see the id
                    println("The post is: " + post.description)
                }
            }
        })
        
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