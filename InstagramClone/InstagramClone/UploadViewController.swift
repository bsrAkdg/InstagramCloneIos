//
//  UploadViewController.swift
//  InstagramClone
//
//  Created by Büşra Serdaroğlu on 4.05.2020.
//  Copyright © 2020 Busra Serdaroglu. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textFieldComment: UITextField!
    
    @IBOutlet weak var btnUpload: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = UIImage(named: "camera")
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        let storage = Storage.storage()
        let reference = storage.reference()
        
        let mediaFolder = reference.child("media") //storage directory name
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data, metadata: nil) { (metaData, error) in
                if error != nil {
                    self.showAlert(title: "Error", message: error?.localizedDescription ?? "Upload not successful")
                } else {
                    print(imageReference.downloadURL(completion: { (url, urlError) in
                        if urlError == nil {
                            let imageUrl = url?.absoluteString
                            
                            // DATABASE
                            
                            let firestoreDatabase = Firestore.firestore() // create database
                            var firestoreReference : DocumentReference? = nil // write - read - listen changes
                            
                            let firestorePost = ["imageUrl" : imageUrl!,
                                                 "postedBy" : Auth.auth().currentUser!.email ?? "",
                                                 "postComment" : self.textFieldComment.text!,
                                                 "date" : FieldValue.serverTimestamp(),
                                                 "likes" : 0] as [String:Any]
                                
                            // collection : like table
                            firestoreReference = firestoreDatabase
                                .collection("Posts")
                                .addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    self.showAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                                } else {
                                    self.imageView.image = UIImage(named: "camera")
                                    self.textFieldComment.text = ""
                                    self.tabBarController?.selectedIndex = 0 // feed tab
                                }
                            })
                            
                        }
                    }))
                }
            }
        }
        
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
