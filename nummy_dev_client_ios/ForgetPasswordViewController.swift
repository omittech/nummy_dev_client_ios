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
    @IBOutlet var logo: UIImageView!
    
    @IBOutlet var email: UIButton!
    @IBOutlet var phone: UIButton!
    
    @IBOutlet var messageView: UIView!
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
        println(logo.constraints())
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func RBSquareImageTo(image: UIImage, size: CGSize) -> UIImage {
        return RBResizeImage(RBSquareImage(image), targetSize: size)
    }
    
    func RBSquareImage(image: UIImage) -> UIImage {
        var originalWidth  = image.size.width
        var originalHeight = image.size.height
        
        var edge: CGFloat
        if originalWidth > originalHeight {
            edge = originalHeight
        } else {
            edge = originalWidth
        }
        
        var posX = (originalWidth  - edge) / 2.0
        var posY = (originalHeight - edge) / 2.0
        
        var cropSquare = CGRectMake(posX, posY, edge, edge)
        
        var imageRef = CGImageCreateWithImageInRect(image.CGImage, cropSquare);
        return UIImage(CGImage: imageRef, scale: UIScreen.mainScreen().scale, orientation: image.imageOrientation)!
    }
    
    func RBResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
}