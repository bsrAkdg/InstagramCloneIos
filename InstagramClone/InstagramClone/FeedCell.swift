//
//  FeedCell.swift
//  InstagramClone
//
//  Created by Büşra Serdaroğlu on 4.05.2020.
//  Copyright © 2020 Busra Serdaroglu. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var labelUserEmail: UILabel!
    @IBOutlet weak var labelUserComment: UILabel!
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var labelLike: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeClicked(_ sender: Any) {
        
    }
    
}
