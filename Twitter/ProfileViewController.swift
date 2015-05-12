//
//  ProfileViewController.swift
//  Twitter
//
//  Created by David Lundgren on 5/10/15.
//  Copyright (c) 2015 David Lundgren. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userRealNameLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userRealNameLabel.text = user.name
        followerCountLabel.text = "\(user.numFollowers!) Followers"
        followingCountLabel.text = "\(user.numFollowing!) Following"
        tweetCountLabel.text = "\(user.numTweets!) Tweets"
        
        let avatarImageURL = NSURL(string: user.profileImageURL!)
        avatarImageView.setImageWithURL(avatarImageURL)
        
        let headerImageURL = NSURL(string: user.bannerImageURL!)
        headerImageView.setImageWithURL(headerImageURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
