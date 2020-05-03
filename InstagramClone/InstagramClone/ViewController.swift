//
//  ViewController.swift
//  InstagramClone
//
//  Created by Büşra Serdaroğlu on 3.05.2020.
//  Copyright © 2020 Busra Serdaroglu. All rights reserved.
//

import UIKit

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
        
    }
    
}

