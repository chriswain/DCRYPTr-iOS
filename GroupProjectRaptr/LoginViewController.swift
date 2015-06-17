//
//  LoginViewController.swift
//  GroupProjectRaptr
//
//  Created by Christopher Wainwright Aaron on 6/17/15.
//  Copyright (c) 2015 Christopher Wainwright Aaron. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enterLoginButton(sender: UIButton) {
        
        storyboard?.instantiateViewControllerWithIdentifier("cameraVC")
    }

   
}
