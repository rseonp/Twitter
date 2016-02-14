//
//  TwitterClient.swift
//  Twitter
//
//  Created by Victor Li Wang on 2/14/16.
//  Copyright © 2016 Victor Li Wang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "cf5q1I0D1qYJYuFV7gqTJDkta"
let twitterConsumerSecret = "hC0BdiiJdhbSS98cZyAGckXg2Oeqn9VdvsEuMCPEU9EvgLNWza"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {

    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
}
