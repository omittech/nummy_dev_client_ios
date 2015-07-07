//
//  SignUpViewController.swift
//  nummy_dev_client_ios
//
//  Created by Ralph Wang on 2015-04-24.
//  Copyright (c) 2015 omittech. All rights reserved.
//

import UIKit
import JavaScriptCore

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var Email: UITextField!
    @IBOutlet var LastName: UITextField!
    @IBOutlet var FirstName: UITextField!
    @IBOutlet var Password: UITextField!
    @IBOutlet var RePassword: UITextField!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBAction func backToLogin(sender: AnyObject) {
        
        performSegueWithIdentifier("SUbackLoginSegue", sender: self)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.Email.delegate = self
        self.LastName.delegate = self
        self.FirstName.delegate = self
        self.Password.delegate = self
        self.RePassword.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        spinner.stopAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func signUpDone(sender: AnyObject) {
        
        spinner.startAnimating()
        
        if (Password.text == RePassword.text) {
            
            var pass: String = Password.text
            
            //encrypt
            // get the project path of aes.js
            let cryptoJSpath = NSBundle.mainBundle().pathForResource("aes", ofType: "js")
            // Retrieve the content of aes.js
            var error:NSError?
            let cryptoJS = String(contentsOfFile: cryptoJSpath!, encoding:NSUTF8StringEncoding, error: &error)
            let cryptoJScontext = JSContext()
            cryptoJScontext.evaluateScript(cryptoJS)
            let encryptFunction = cryptoJScontext.objectForKeyedSubscript("encrypt")
            let decryptFunction = cryptoJScontext.objectForKeyedSubscript("decrypt")
            var encrypted = encryptFunction.callWithArguments([pass, "thisisakey"])
            var encryptedString = encrypted.toString()
            println(encryptedString)
            var decrypted = decryptFunction.callWithArguments([encrypted, "thisisakey"])
            println(decrypted)
            
            // MARK: POST
            // Create new post
            var postsEndpoint: String = baseUrl + "/api/user"
            var postsUrlRequest = NSMutableURLRequest(URL: NSURL(string: postsEndpoint)!)
            postsUrlRequest.HTTPMethod = "POST"
            
            var newPost: NSDictionary = ["username": Email.text, "password": encryptedString, "firstname": FirstName.text, "lastname": LastName.text];
            var postJSONError: NSError?
            var jsonPost = NSJSONSerialization.dataWithJSONObject(newPost, options: nil, error:  &postJSONError)
            postsUrlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            postsUrlRequest.HTTPBody = jsonPost
            
            var data: NSData!
            var jsonError: NSError?
            data = NSURLConnection.sendSynchronousRequest(postsUrlRequest, returningResponse: nil, error: &jsonError)
            let post = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary
            
            spinner.stopAnimating()
            
            if (user.status == "ok") {
                
                user.resetUser()
                user.setStatus(post.valueForKey("status") as! String)
                user.setUsername(post.valueForKey("data")?.valueForKey("username") as! String)
                
                var alertView = UIAlertView();
                alertView.addButtonWithTitle("OK");
                alertView.title = "Sign-up";
                alertView.message = "Sign-up finished";
                alertView.show();

                performSegueWithIdentifier("signUpSuccessSegue", sender: self)
                
            }
            
            else {
                
                var alertView = UIAlertView();
                alertView.addButtonWithTitle("OK");
                alertView.title = "Sign-up";
                alertView.message = "Sign-up failed";
                alertView.show();
                
            }
            
        }
        else {
        
            spinner.stopAnimating()
            
            //password and re-password are different
            var alertView = UIAlertView();
            alertView.addButtonWithTitle("OK");
            alertView.title = "Sign-up failed";
            alertView.message = "Passwords do not match";
            alertView.show();
            
            //reset the password fields for user to retry
            Password.text = ""
            RePassword.text = ""
            
        }
    }
}
