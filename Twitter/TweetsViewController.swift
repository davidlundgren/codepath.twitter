//
//  TweetsViewController.swift
//  Twitter
//
//  Created by David Lundgren on 5/4/15.
//  Copyright (c) 2015 David Lundgren. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetViewControllerDelegate {
    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadData", name: userDidPostTweetNotification, object: nil)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self

        self.loadData()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(refreshControl, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetViewCell", forIndexPath: indexPath) as! TweetViewCell
        let tweet = tweets![indexPath.row]
        cell.userLabel.text = tweet.user!.name!
        cell.tweetBodyLabel.text = tweet.text!
        
        let url = NSURL(string: tweet.user!.profileImageURL!)
        cell.userAvatarView.setImageWithURL(url)
        cell.timeStampLabel.text = tweet.createdAtNiceString!
        
        return cell
    }
    

 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let tweetViewController = navigationController.topViewController as! TweetViewController
        tweetViewController.delegate = self
    }


    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }

    
    func onRefresh() {
        self.loadData()
        self.refreshControl.endRefreshing()
    }
    
    func loadData() {
        println("loading data")
        TwitterClient.sharedInstance.timeLine(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
    }
    
    
    func tweetViewController(tweetViewController: TweetViewController) {
        println("delegate")
        self.loadData()
    }
    
}
