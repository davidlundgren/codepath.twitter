//
//  ViewController.swift
//  Twitter
//
//  Created by David Lundgren on 5/2/15.
//  Copyright (c) 2015 David Lundgren. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            println("Got the request token")
            let authString = "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)"
            let authURL = NSURL(string: authString)
            UIApplication.sharedApplication().openURL(authURL!)
            }) {(error:NSError!) -> Void in
                println("Failed to get request token")
        }
    }
    
}

