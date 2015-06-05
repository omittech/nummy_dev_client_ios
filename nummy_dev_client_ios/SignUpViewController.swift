//
//  SignUpViewController.swift
//  nummy_dev_client_ios
//
//  Created by Ralph Wang on 2015-04-24.
//  Copyright (c) 2015 omittech. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var Email: UITextField!
    @IBOutlet var Name: UITextField!
    @IBOutlet var Phone: UITextField!
    @IBOutlet var Password: UITextField!
    @IBOutlet var RePassword: UITextField!
    
    @IBAction func backToLogin(sender: AnyObject) {
        performSegueWithIdentifier("SUbackLoginSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.Email.delegate = self
        self.Name.delegate = self
        self.Phone.delegate = self
        self.Password.delegate = self
        self.RePassword.delegate = self
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
        
        if (Password.text == RePassword.text) {
            
            // MARK: POST
            // Create new post
            var postsEndpoint: String = "http://ancient-taiga-3819.herokuapp.com/api/user"
            var postsUrlRequest = NSMutableURLRequest(URL: NSURL(string: postsEndpoint)!)
            postsUrlRequest.HTTPMethod = "POST"
            
            var newPost: NSDictionary = ["username": Email.text, "password": Password.text, "firstname": Name.text, "lastname": Name.text, "phone": Phone.text, "email": Email.text];
            var postJSONError: NSError?
            var jsonPost = NSJSONSerialization.dataWithJSONObject(newPost, options: nil, error:  &postJSONError)
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
            
            //can't get connection to server at this point -20150603
            performSegueWithIdentifier("signUpSuccessSegue", sender: self)

            
        }
        else {
        
            //password and re-password are different
            
        }
    }
}