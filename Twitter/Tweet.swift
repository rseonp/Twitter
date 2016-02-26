//
//  Tweet.swift
//  Twitter
//
//  Created by Victor Li Wang on 2/16/16.
//  Copyright © 2016 Victor Li Wang. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var id: String?
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var retweeted: Bool?
    var favoritesCount: Int = 0
    var favorited: Bool?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        print(retweetCount)
        favoritesCount = (dictionary["user"]!["favourites_count"] as? Int) ?? 0
        print(favoritesCount)
        retweeted = dictionary["retweeted"] as? Bool
        favorited = dictionary["favorited"] as? Bool
        
        let timestampString = dictionary["created_at"] as? String
        id = dictionary["id_str"] as? String
        
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }
}
