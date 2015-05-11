//
//  User.swift
//  Twitter
//
//  Created by David Lundgren on 5/4/15.
//  Copyright (c) 2015 David Lundgren. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUser"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification =  "userDidLogoutNotification"
let userDidPostTweetNotification = "userDidPostTweet"

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileImageURL: String?
    var bannerImageURL: String?
    var arrogantSelfDescription: String?

    var numTweets: Int?
    var numFollowers: Int?
    var numFollowing: Int?
    
    var dictionary: NSDictionary
    
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageURL = dictionary["profile_image_url"] as? String
        bannerImageURL = dictionary["profile_banner_url"] as? String
        arrogantSelfDescription = dictionary["description"] as? String
        
        numFollowers = dictionary["followers_count"] as? Int
        numFollowing = dictionary["following"] as? Int
        numTweets = dictionary["statuses_count"] as? Int
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)

            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
