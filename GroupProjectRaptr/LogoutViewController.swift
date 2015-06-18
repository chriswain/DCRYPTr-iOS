//
//  LogoutViewController.swift
//  GroupProjectRaptr
//
//  Created by Christopher Wainwright Aaron on 6/17/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let checkedData = NSUserDefaults.standardUserDefaults()
        let loggedIn: Int = checkedData.integerForKey("loggedIn") as Int
        
        if loggedIn != 1 {
            performSegueWithIdentifier("loginVC", sender: self)
        } else {
            usernameLabel.text = checkedData.valueForKey("username") as? String
        }
        
    }
    

 
    @IBAction func logoutButton(sender: UIButton) {
       
        performSegueWithIdentifier("loginVC", sender: self)
        
    }
    

}
