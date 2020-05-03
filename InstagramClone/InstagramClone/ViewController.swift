//
//  ViewController.swift
//  InstagramClone
//
//  Created by Büşra Serdaroğlu on 3.05.2020.
//  Copyright © 2020 Busra Serdaroglu. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signIn(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: nil)
    }
    
    @IBAction func signUp(_ sender: Any) {
        if textFieldEmail.text != "" && textFieldPassword.text != "" {
            Auth.auth().createUser(withEmail: textFieldEmail.text!, password: textFieldPassword.text!) { (authData, error) in
                if error != nil {
                    self.showAlert(title: error?.localizedDescription ?? "Firebase auth error")
                } else {
                    self.performSegue(withIdentifier: "goHome", sender: nil)
                }
            }
        } else {
           showAlert(title: "Username/Passowrd?")
        }

    }
    
    func showAlert(title: String) {
        let alert = UIAlertController(title: "Warning", message: title, preferredStyle: .alert)
                   
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

