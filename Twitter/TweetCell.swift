//
//  TweetCell.swift
//  Twitter
//
//  Created by Victor Li Wang on 2/21/16.
//  Copyright © 2016 Victor Li Wang. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!

    var tweet: Tweet! {
        didSet {
            usernameLabel.text = tweet.user?.name
            profileImageView.setImageWithURL((tweet.user?.profileUrl)!)
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = .ShortStyle
            formatter.timeStyle = .ShortStyle
            let dateString = formatter.stringFromDate((tweet.timestamp)!)
            timestampLabel.text = dateString
            tweetLabel.text = tweet.text
            
            retweetCountLabel.text = "\(tweet.retweetCount)"
//            favoriteCountLabel.text = "\(tweet.favoritesCount)"
            
            if(tweet.retweeted == true) {
                retweetButton.setImage(UIImage(named: "retweet-action-on.png"), forState: .Normal)
//                retweetButton.selected = true
//                print("retweetselected = true in TweetCell")
            } else {
                retweetButton.setImage(UIImage(named: "retweet-action.png"), forState: .Normal)
//                retweetButton.selected = false
//                print("retweetselected = false in TweetCell")
            }
            
            if(tweet.favorited == true) {
                favoriteButton.setImage(UIImage(named: "like-action-on.png"), forState: .Normal)
//                favoriteButton.selected = true
//                print("favoriteselected = true in TweetCell")
            } else {
                favoriteButton.setImage(UIImage(named: "like-action.png"), forState: .Normal)
//                favoriteButton.selected = false
//                print("favoriteselected = false in TweetCell")
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        
        usernameLabel.preferredMaxLayoutWidth = usernameLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        usernameLabel.preferredMaxLayoutWidth = usernameLabel.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
