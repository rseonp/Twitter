//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Victor Li Wang on 2/23/16.
//  Copyright © 2016 Victor Li Wang. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        usernameLabel.text = tweet.user?.name
//        usernameLabel.sizeToFit()
        profileImageView.setImageWithURL((tweet.user?.profileUrl)!)
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .ShortStyle
        let dateString = formatter.stringFromDate((tweet.timestamp)!)
        timestampLabel.text = dateString
        tweetLabel.text = tweet.text
//        retweetButton.setImage(UIImage(named: "retweet-action.png"), forState: .Normal)
//        favoriteButton.setImage(UIImage(named: "like-action.png"), forState: .Normal)
        replyButton.setImage(UIImage(named: "reply-action_0.png"), forState: .Normal)
        
        if(tweet.retweeted == true) {
            retweetButton.setImage(UIImage(named: "retweet-action-on.png"), forState: .Normal)
//            retweetButton.selected = true
            //                print("retweetselected = true in TweetCell")
        } else {
            retweetButton.setImage(UIImage(named: "retweet-action.png"), forState: .Normal)
//            retweetButton.selected = false
            //                print("retweetselected = false in TweetCell")
        }
        
        if(tweet.favorited == true) {
            favoriteButton.setImage(UIImage(named: "like-action-on.png"), forState: .Normal)
//            favoriteButton.selected = true
            //                print("favoriteselected = true in TweetCell")
        } else {
            favoriteButton.setImage(UIImage(named: "like-action.png"), forState: .Normal)
//            favoriteButton.selected = false
            //                print("favoriteselected = false in TweetCell")
        }

        
//        print(tweet)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweet(sender: AnyObject) {
        print("retweet pressed")
        
        
//        if(retweetButton.selected == true) {
        if(tweet.retweeted == true) {
            TwitterClient.sharedInstance.unretweet(tweet.id!, success: { (tweet: Tweet) -> () in
                print("tweet.retweeted = true")
                self.tweet.retweeted = false
                tweet.retweetCount--
                self.retweetButton.setImage(UIImage(named: "retweet-action.png"), forState: .Normal)
//                self.retweetButton.selected = false
                //                            self.tableView.reloadData()
                print("unretweetPressed success")
                }, failure: { () -> () in
                    print("unretweetPressed failure")
            })
        } else{
            TwitterClient.sharedInstance.retweet(tweet.id!, success: { (tweet: Tweet) -> () in
                print("tweet.retweeted is false")
                self.tweet.retweeted = true
                tweet.retweetCount++
                self.retweetButton.setImage(UIImage(named: "retweet-action-on.png"), forState: .Normal)
//                self.retweetButton.selected = true
                //                            self.tableView.reloadData()
                print("retweetPressed success")
                }, failure: { () -> () in
                    print("retweetPressed failure")
            })
        }
    }

    @IBAction func onFavorite(sender: AnyObject) {
                print("favorite pressed")
//        if(favoriteButton.selected == true) {
        if(tweet.favorited == true) {
            print("tweet.favorited is true")
            TwitterClient.sharedInstance.unfavorite(tweet.id!, success: { (tweet: Tweet) -> () in
                self.tweet.favorited = false
                tweet.favoritesCount--
                self.favoriteButton.setImage(UIImage(named: "like-action.png"), forState: .Normal)
//                self.favoriteButton.selected = false
                //                            self.tableView.reloadData()
                print(tweet.favorited)
                print("unfavoritePressed success")
                }, failure: { (error: NSError) -> () in
                    print(error.localizedDescription)
                    print("unfavoritePressed failure")
            })
        } else{
            print("tweet.favorited is false")
            TwitterClient.sharedInstance.favorite(tweet.id!, success: { (tweet: Tweet) -> () in
                self.tweet.favorited = true
                tweet.favoritesCount++
                self.favoriteButton.setImage(UIImage(named: "like-action-on.png"), forState: .Normal)
//                self.favoriteButton.selected = true
                //                            self.tableView.reloadData()
                print(tweet.favorited)
                print("favoritePressed success")
                }, failure: { (error: NSError) -> () in
                    print(error.localizedDescription)
                    print("favoritePressed failure")
            })
        }
    }


    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "replySegue") {
            let replyTweetViewController = segue.destinationViewController as! ReplyTweetViewController
            replyTweetViewController.tweet = tweet
            print(tweet.user?.name)
            print("prepare for replySegue")
        } else {
            
            let profileDetailViewController = segue.destinationViewController as! ProfileDetailViewController
            //        print("BOUT TO SET")
            profileDetailViewController.tweet = tweet
            print(tweet.user?.name)
            print("Prepare for segue in TweetDetailViewController")
        }
    }
    

}
