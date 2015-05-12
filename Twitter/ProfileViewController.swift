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
        if user == nil {
            user = User.currentUser
        }
        
        userRealNameLabel.text = user.name
        followerCountLabel.text = "\(user.numFollowers!) Followers"
        followingCountLabel.text = "\(user.numFollowing!) Following"
        tweetCountLabel.text = "\(user.numTweets!) Tweets"
        
        let avatarImageURL = NSURL(string: user.profileImageURL!)
        avatarImageView.setImageWithURL(avatarImageURL)
        
        // This can be nil, but ehhhhh
        let headerImageURL = NSURL(string: user.bannerImageURL!)
        headerImageView.setImageWithURL(headerImageURL)
        
        if self.revealViewController() != nil {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
