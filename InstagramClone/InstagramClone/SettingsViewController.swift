//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by Büşra Serdaroğlu on 4.05.2020.
//  Copyright © 2020 Busra Serdaroglu. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "goLogin", sender: nil)
        } catch {
            print("Sign out error")
        }
    }
}
