//
//  ReplyTweetViewController.swift
//  Twitter
//
//  Created by Victor Li Wang on 3/4/16.
//  Copyright © 2016 Victor Li Wang. All rights reserved.
//

import UIKit

class ReplyTweetViewController: UIViewController {

    @IBOutlet weak var tweetText: UITextView!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetText.becomeFirstResponder()
        print(tweet.user?.name)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.tweet(("@" + (tweet.user?.name)! + " " + tweetText.text).stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!, success: { () -> () in
            print("tweet success in ReplyTweetViewController")
            self.dismissViewControllerAnimated(false, completion: nil)
            }) { () -> () in
                print("error tweeting")
        }
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
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
