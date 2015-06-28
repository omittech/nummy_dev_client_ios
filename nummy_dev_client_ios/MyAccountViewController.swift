//
//  SignUpViewController.swift
//  nummy_dev_client_ios
//
//  Created by Ralph Wang on 2015-04-24.
//  Copyright (c) 2015 omittech. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var rePwdTextField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBAction func submitEdit(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.emailTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.firstNameTextField.delegate = self
        self.pwdTextField.delegate = self
        self.rePwdTextField.delegate = self
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
        
        if (pwdTextField.text == rePwdTextField.text) {
            
            // MARK: POST
            // Create new post
            var postsEndpoint: String = baseUrl + "/api/user"
            var postsUrlRequest = NSMutableURLRequest(URL: NSURL(string: postsEndpoint)!)
            postsUrlRequest.HTTPMethod = "POST"
            
            var newPost: NSDictionary = ["username": emailTextField.text, "password": pwdTextField.text, "firstname": firstNameTextField.text, "lastname": lastNameTextField.text];
            var postJSONError: NSError?
            var jsonPost = NSJSONSerialization.dataWithJSONObject(newPost, options: nil, error:  &postJSONError)
            postsUrlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            postsUrlRequest.HTTPBody = jsonPost
            
            var data: NSData!
            var jsonError: NSError?
            data = NSURLConnection.sendSynchronousRequest(postsUrlRequest, returningResponse: nil, error: &jsonError)
            /*var status: NSString! = data.valueForKey("status") as! NSString
            if (status == "fail") {
            //sign up failed
            }
            else {
            performSegueWithIdentifier("signUpSuccessSegue", sender: self)
            }*/
            println("The post is:" + data.description)
            
            spinner.stopAnimating()
            
            var alertView = UIAlertView();
            alertView.addButtonWithTitle("OK");
            alertView.title = "Sign-up";
            alertView.message = "Sign-up finished";
            alertView.show();
            
            //can't get connection to server at this point -20150603
            performSegueWithIdentifier("signUpSuccessSegue", sender: self)
            
            
        }
        else {
            
            spinner.stopAnimating()
            
            //password and re-password are different
            var alertView = UIAlertView();
            alertView.addButtonWithTitle("OK");
            alertView.title = "Sign-up failed";
            alertView.message = "Passwords do not match";
            alertView.show();
            
        }
    }
}
