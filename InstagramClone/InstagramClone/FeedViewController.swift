//
//  FeedViewController.swift
//  InstagramClone
//
//  Created by Büşra Serdaroğlu on 4.05.2020.
//  Copyright © 2020 Busra Serdaroglu. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        getDataFromFirestore()
    }
    
    func getDataFromFirestore() {
        let fireStoreDatabase = Firestore.firestore()
       
        /*let settings = fireStoreDatabase.settings
        settings.areTimestampsInSnapshotsEnabled = true
        fireStoreDatabase.settings = settings */
        
        fireStoreDatabase
            .collection("Posts")
            .order(by: "date", descending: true) // sort by date
            .addSnapshotListener { (snapshot, error) in
            if error != nil {
                
            } else {
                
                if snapshot != nil && snapshot?.isEmpty != true {
                    // documents inside snapshot : snapshot?.documents
                    self.posts.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        
                        let newPost = Post()
                        
                        newPost.documentId = document.documentID
                        
                        if let postedBy = document.get("postedBy") as? String {
                            newPost.postedBy = postedBy
                        }
                        
                        if let imageUrl = document.get("imageUrl") as? String {
                            newPost.imageUrl = imageUrl
                        }
                        
                        if let postComment = document.get("postComment") as? String {
                            newPost.postComment = postComment
                        }
                        
                        if let likes = document.get("likes") as? Int {
                            newPost.likes = likes
                        }
                        
                        if let date = document.get("date") as? String {
                            newPost.date = date
                        }
                        self.posts.append(newPost)
                    }
                    
                    self.tableView.reloadData()
                }
              
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        
        let post = posts[indexPath.row]
        
        cell.labelUserComment.text = post.postComment
        cell.labelUserEmail.text = post.postedBy
        cell.labelLike.text = String(post.likes ?? 0)
        cell.imagePost.sd_setImage(with: URL(string: post.imageUrl!))
        cell.documentId = post.documentId
        
        return cell
    }
    


}
