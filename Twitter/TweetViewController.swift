//
//  TweetViewController.swift
//  Twitter
//
//  Created by David Lundgren on 5/4/15.
//  Copyright (c) 2015 David Lundgren. All rights reserved.
//

import UIKit
import Darwin

@objc protocol TweetViewControllerDelegate {
    optional func tweetViewController(tweetViewController: TweetViewController)
}

class TweetViewController: UIViewController {


    @IBOutlet weak var tweetField: UITextField!
    weak var delegate: TweetViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onComposeTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.updateStatus(tweetField.text, parameters: nil)
        //self.performSegueWithIdentifier("timelineSegue", sender: self)
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.tweetViewController?(self)
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let homeViewController = segue.destinationViewController as! TweetsViewController
//        homeViewController.loadData()
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
