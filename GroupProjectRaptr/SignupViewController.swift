//
//  SignupViewController.swift
//  GroupProjectRaptr
//
//  Created by Christopher Wainwright Aaron on 6/17/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UIAlertViewDelegate {
    
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func enterSignupButton(sender: UIButton) {
        
        let fullName = fullNameTextField.text
        let username = usernameTextField.text
        let password = passwordTextField.text
        
        fullName.stringByReplacingOccurrencesOfString(" ", withString: "+", options: nil, range: nil)
        username.stringByReplacingOccurrencesOfString(" ", withString: "+", options: nil, range: nil)
        password.stringByReplacingOccurrencesOfString(" ", withString: "+", options: nil, range: nil)
        
        if username.isEmpty || password.isEmpty || fullName.isEmpty {
            
            let alertView = UIAlertView()
            alertView.title = "Invalid Sign Up"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        } else {
            
            let endpoint = "" // endpoint from backend
            
            let post = "fullname=\(fullName)&username=\(username)&password=\(password)"
            
            println("Post data:\(post)")
            
            if let url = NSURL(string: "\(endpoint)\(post)") { // need endpoint for the backend server
                println("\(url)")
                let request = NSMutableURLRequest(URL: url)
                
                let session = NSURLSession.sharedSession()
                request.HTTPMethod = "POST"
                
                var params = ["username":"\(username)", "password":"\(password)", "fullname":"\(fullName)"] as [String:String]
                
                var error: NSError?
                request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &error)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.addValue("application/json", forHTTPHeaderField: "Accept")
                
                var task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                    
                    println("Response: \(response)")
                    
                    var stringData = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Body: \(stringData)")
                    var error: NSError?
                    var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &error) as? NSDictionary
                    
                    if error != nil { //json object with data returns an error
                        println(error?.localizedDescription)
                        let jsonString = NSString(data: data, encoding: NSUTF8StringEncoding)
                        println("Error could not parse JSON: \(jsonString)")
                        
                        let alertView = UIAlertView()
                        alertView.title = "Invalid Sign Up"
                        alertView.message = "Please enter Username and Password"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()

                    } else {
                        // did not return error but still check to make sure json has a value
                        if let parseJSON = json {
                            
                            var success = parseJSON["success"] as? Int //replace success with what backend did
                            println("Sucess: \(success)")
                            self.storyboard?.instantiateViewControllerWithIdentifier("cameraVC")
                            self.dismissViewControllerAnimated(true, completion: nil)
                            
                            
                        } else {
                            let jsonString = NSString(data: data, encoding: NSUTF8StringEncoding)
                            println("Error could not parse JSON: \(jsonString)")
                            let alertView = UIAlertView()
                            alertView.title = "Invalid Sign Up"
                            alertView.message = "Please enter Username and Password"
                            alertView.delegate = self
                            alertView.addButtonWithTitle("OK")
                            alertView.show()

                        }
                    }
                })
                
            }
            
            
            
            
            
            
            
        }
        
    }
    
}
