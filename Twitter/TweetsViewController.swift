//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Victor Li Wang on 2/20/16.
//  Copyright © 2016 Victor Li Wang. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension //autolayout
        tableView.estimatedRowHeight = 120
        
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            //            for tweet in tweets {
            //                print(tweet.user?.name)
            //                print(tweet.text)
            //            }
            self.tableView.reloadData()
            //reload table
            
            }) { (error: NSError) -> () in
                print("Error: \(error.localizedDescription)")
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    @IBAction func retweetPressed(sender: AnyObject) {
        if let button = sender as? UIButton {
            if let superview = button.superview {
                if let cell = superview.superview as? TweetCell {
                    print(cell.tweet.id!)
                    
//                    if(cell.retweetButton.selected == true) {
                        if(cell.tweet.retweeted == true) {
                        TwitterClient.sharedInstance.unretweet(cell.tweet.id!, success: { (tweet: Tweet) -> () in
                            cell.tweet.retweeted = false
                            cell.tweet.retweetCount--
                            self.tableView.reloadData()
                            print("unretweetPressed success")
                            }, failure: { () -> () in
                                print("unretweetPressed failure")
                        })
                    } else{
                        TwitterClient.sharedInstance.retweet(cell.tweet.id!, success: { (tweet: Tweet) -> () in
                            cell.tweet.retweeted = true
                            cell.tweet.retweetCount++
                            self.tableView.reloadData()
                            print("retweetPressed success")
                            }, failure: { () -> () in
                                print("retweetPressed failure")
                        })
                    }
                }
            }
        }
    }
    
    @IBAction func favoritePressed(sender: AnyObject) {
        if let button = sender as? UIButton {
            if let superview = button.superview {
                if let cell = superview.superview as? TweetCell {
                    print(cell.tweet.id!)
                    
//                    if(cell.favoriteButton.selected == true) {
                    if(cell.tweet.favorited == true) {
                        TwitterClient.sharedInstance.unfavorite(cell.tweet.id!, success: { (tweet: Tweet) -> () in
                            cell.tweet.favorited = false
                            cell.tweet.favoritesCount--
                            self.tableView.reloadData()
                            print("unfavoritePressed success")
                            }, failure: { (error: NSError) -> () in
                                print(error.localizedDescription)
                                print("unfavoritePressed failure")
                        })
                    } else{
                        TwitterClient.sharedInstance.favorite(cell.tweet.id!, success: { (tweet: Tweet) -> () in
                            cell.tweet.favorited = true
                            cell.tweet.favoritesCount++
                            self.tableView.reloadData()
                            print("favoritePressed success")
                            }, failure: { (error: NSError) -> () in
                                print(error.localizedDescription)
                                print("favoritePressed failure")
                        })
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            }) { (error: NSError) -> () in
                print("Error: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "tweetSegue" {
            print("prepare for tweetSegue")
        } else {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            //        print(tweet)
            print("about to create vc")
            let tweetDetailViewController = segue.destinationViewController as! TweetDetailViewController
            print("BOUT TO SET")
            tweetDetailViewController.tweet = tweet
            print(tweet.user?.name)
            print("Prepare for segue in TweetsViewController")
        }
    }
    
    
}
