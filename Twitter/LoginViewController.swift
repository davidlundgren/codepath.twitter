//
//  ViewController.swift
//  Twitter
//
//  Created by David Lundgren on 5/2/15.
//  Copyright (c) 2015 David Lundgren. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            self.view.userInteractionEnabled = true
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                println("LOGIN FAILED BUT THAT'S OKAY WE ALL MAKE MISTAKES")
            }
        }

    }
    
}

