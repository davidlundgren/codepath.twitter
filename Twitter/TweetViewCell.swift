//
//  TweetViewCell.swift
//  Twitter
//
//  Created by David Lundgren on 5/4/15.
//  Copyright (c) 2015 David Lundgren. All rights reserved.
//

import UIKit

class TweetViewCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetBodyLabel: UILabel!
    @IBOutlet weak var userAvatarView: UIImageView!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
