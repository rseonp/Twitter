//
//  ProfileDetailViewController.swift
//  Twitter
//
//  Created by Victor Li Wang on 2/23/16.
//  Copyright © 2016 Victor Li Wang. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetCount: UILabel!
    
    @IBOutlet weak var followingCount: UILabel!
    
    @IBOutlet weak var followersCount: UILabel!
    
    var tweet: Tweet!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameLabel.text = tweet.user?.name
        profileImageView.setImageWithURL((tweet.user?.profileUrl)!)
        tweetCount.text = "\(tweet.user!.numTweets)"
        followersCount.text = "\(tweet.user!.numFollowers)"
        followingCount.text = "\(tweet.user!.numFollowing)"
        
        // Do any additional setup after loading the view.
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
