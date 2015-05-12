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
    
    var window: UIWindow?
    var storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        
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
        if let favorited = tweet.favorited {
            if favorited {
                cell.favoriteImageView.image = UIImage(named: "favorite_on")
            }
        }
        return cell
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController
        if vc.isMemberOfClass(UINavigationController) {
            let navigationController = segue.destinationViewController as! UINavigationController
            let tweetViewController = navigationController.topViewController as! TweetViewController
            tweetViewController.delegate = self
        } else if vc.isMemberOfClass(ProfileViewController) {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)!
            let tweet = tweets![indexPath.row]
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.user = tweet.user
        }
        
    }
    
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    
    func onRefresh() {
        self.loadData()
        self.refreshControl.endRefreshing()
    }
    
    func loadData() {
        TwitterClient.sharedInstance.timeLine(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
    }
    
    
    func tweetViewController(tweetViewController: TweetViewController) {
        self.loadData()
    }
    
    
    
}
