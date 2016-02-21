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
