//
//  TwitterClient.swift
//  Twitter
//
//  Created by David Lundgren on 5/2/15.
//  Copyright (c) 2015 David Lundgren. All rights reserved.
//

import UIKit

let twitterConsumerKey = "jxNqhGqTPvlQoZLUELQv6KJ90"
let twitterConsumerSecret = "p6bDqFTeyK4zpkHtZy3BIWAkEaOTWr44ygSpdaVgnDDYEcTomO"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func timeLine(parameters: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: parameters, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println("timeline: \(response)")
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error getting timeline")
                completion(tweets: nil, error: error)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        requestSerializer.removeAccessToken()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            
            println("Got the request token")
            let authString = "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)"
            let authURL = NSURL(string: authString)
            
            UIApplication.sharedApplication().openURL(authURL!)
            }) {(error:NSError!) -> Void in
                println("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: {(accessToken: BDBOAuth1Credential!) -> Void in
            
            println("Got the access token!")
            self.requestSerializer.saveAccessToken(accessToken)
            
            
            self.GET("1.1/account/verify_credentials.json", parameters: nil, success: {(operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                println("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                }, failure: {(operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            
            }) { (error: NSError!) -> Void in
                println("Failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
}
