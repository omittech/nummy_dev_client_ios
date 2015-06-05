//
//  ViewController.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/4/20.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, UITextFieldDelegate {
    
    //need to change the login button from phone into email(UI) -20150603
    
    @IBOutlet var password_field: UITextField!
    
    @IBOutlet var username_field: UITextField!
    
    // Facebook Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        println("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
                var storyboard = UIStoryboard(name: "chefs", bundle: nil)
                var controller = storyboard.instantiateViewControllerWithIdentifier("chefList") as! UIViewController
                presentViewController(controller, animated: true, completion: nil)
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
            }
            else
            {
                println("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                println("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                println("User Email is: \(userEmail)")
            }
        })
    }
    
    @IBAction func forgetPassword(sender: AnyObject) {
        performSegueWithIdentifier("forgetPasswordSegue", sender: self)
    }
    
    @IBAction func signUp(sender: AnyObject) {
        performSegueWithIdentifier("signUpSegue", sender: self)
    }
    
    @IBAction func Login(sender: AnyObject) {
        var username = username_field.text
        var password = password_field.text
        
        //check the database to see if the un/pw are correct
        if loginCheck(Username: username, Password: password) {
            performSegueWithIdentifier("loginSuccessSegue", sender: self)
        }
        else {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.password_field.delegate = self
        self.username_field.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
            println("FB account already login")
            var storyboard = UIStoryboard(name: "chefs", bundle: nil)
            var controller = storyboard.instantiateViewControllerWithIdentifier("chefList") as! UIViewController
            presentViewController(controller, animated: true, completion: nil)
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.frame.origin.y = 550
            loginView.alpha = 0.8
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginCheck(Username username: String, Password password: String)->Bool {

        // MARK: POST
        // Create new post
        var postsEndpoint: String = "http://ancient-taiga-3819.herokuapp.com/api/login"
        var postsUrlRequest = NSMutableURLRequest(URL: NSURL(string: postsEndpoint)!)
        postsUrlRequest.HTTPMethod = "POST"
        
        var newPost: NSDictionary = ["username": username, "password": password];
        var postJSONError: NSError?
        var jsonPost = NSJSONSerialization.dataWithJSONObject(newPost, options: nil, error:  &postJSONError)
        postsUrlRequest.HTTPBody = jsonPost
        
        var data: NSData!
        data = NSURLConnection.sendSynchronousRequest(postsUrlRequest, returningResponse: nil, error: &postJSONError)
        var jsonError: NSError?
        let post = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary
        /*let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError)
        if let unwrappedError = jsonError {
            println("json error: \(unwrappedError)")
        } else {
            //println("The post is:" + post.description)
        }*/
        var status: NSString! = post.valueForKey("status") as! NSString
        if (status == "fail") {
            
            println("login failed")
            return false
        }
        println("login success")
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
}

