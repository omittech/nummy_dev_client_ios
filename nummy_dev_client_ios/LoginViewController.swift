//
//  ViewController.swift
//  nummy_dev_client_ios
//
//  Created by Guangyu Wang on 15/4/20.
//  Copyright (c) 2015年 omittech. All rights reserved.
//

import UIKit
import JavaScriptCore

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, UITextFieldDelegate {
    
    //need to change the login button from phone into email(UI) -20150603
    
    @IBOutlet var password_field: UITextField!
    
    @IBOutlet var username_field: UITextField!

    @IBOutlet var spinner: UIActivityIndicatorView!
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
            
            //if login success, then segue to next page
            spinner.stopAnimating()
            println("spinner end")
            performSegueWithIdentifier("loginSuccessSegue", sender: self)
            
        }
        else {
            
            //if login failed, pop-up a alert
            spinner.stopAnimating()
            println("spinner end")
            
            var alertView = UIAlertView();
            alertView.addButtonWithTitle("OK");
            alertView.title = "Login failed";
            alertView.message = user.getMessage();
            alertView.show();
            
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.password_field.delegate = self
        self.username_field.delegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        spinner.stopAnimating()
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            
            // User is already logged in, do work such as go to next view controller.
            println("FB account already login")
            var storyboard = UIStoryboard(name: "chefs", bundle: nil)
            var controller = storyboard.instantiateViewControllerWithIdentifier("chefList") as! UIViewController
            presentViewController(controller, animated: true, completion: nil)
            
        }
        else {
            
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
        
        println("spinner start")
        spinner.startAnimating()
        
        // get the project path of aes.js
        let cryptoJSpath = NSBundle.mainBundle().pathForResource("aes", ofType: "js")
        // Retrieve the content of aes.js
        var error:NSError?
        let cryptoJS = String(contentsOfFile: cryptoJSpath!, encoding:NSUTF8StringEncoding, error: &error)
        let cryptoJScontext = JSContext()
        cryptoJScontext.evaluateScript(cryptoJS)
        let encryptFunction = cryptoJScontext.objectForKeyedSubscript("encrypt")
        let decryptFunction = cryptoJScontext.objectForKeyedSubscript("decrypt")
        var encrypted = encryptFunction.callWithArguments([password, "thisisakey"])
        var encryptedString = encrypted.toString()
        println(encryptedString)
        var decrypted = decryptFunction.callWithArguments([encrypted, "thisisakey"])
        println(decrypted)
        
        // MARK: POST
        // Create new post
        var postsEndpoint: String = baseUrl + "/api/login"
        var postsUrlRequest = NSMutableURLRequest(URL: NSURL(string: postsEndpoint)!)
        postsUrlRequest.HTTPMethod = "POST"
        var newPost: NSDictionary = ["username": username, "password": encryptedString];
        var postJSONError: NSError?
        var jsonPost = NSJSONSerialization.dataWithJSONObject(newPost, options: nil, error:  &postJSONError)
        postsUrlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        postsUrlRequest.HTTPBody = jsonPost
        
        var data: NSData!
        data = NSURLConnection.sendSynchronousRequest(postsUrlRequest, returningResponse: nil, error: &postJSONError)
        var jsonError: NSError?
        let post = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary
        
        if (user.getStatus() != "blank") {
            
            var newUser = UserVO(dictionary: post)
            user.setUser(newUser)
        
        }
        user = UserVO(dictionary: post)
        if (user.getStatus() == "fail") {
            
            println(user.getMessage())
            return false
        }
        println(user.getMessage())
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

