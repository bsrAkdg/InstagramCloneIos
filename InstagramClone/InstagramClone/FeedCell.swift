//
//  FeedCell.swift
//  InstagramClone
//
//  Created by Büşra Serdaroğlu on 4.05.2020.
//  Copyright © 2020 Busra Serdaroglu. All rights reserved.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    @IBOutlet weak var labelUserEmail: UILabel!
    @IBOutlet weak var labelUserComment: UILabel!
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var labelLike: UILabel!
    
    var documentId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeClicked(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(labelLike.text!) {
            
            let likeDocument = ["likes" : likeCount + 1] as [String : Any]
            
            firestoreDatabase
                .collection("Posts")
                .document(documentId!)
                .setData(likeDocument, merge: true) // update with new like count

        }
        
    }
    
}
