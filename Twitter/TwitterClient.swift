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
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
}
