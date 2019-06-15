//
//  ViewController.swift
//  University Events Management
//
//  Created by Hollyn Derisse on 6/15/19.
//  Copyright © 2019 Hollyn Derisse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // properties
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func bgOutside(_ sender: UITapGestureRecognizer) {
        
        emailField.resignFirstResponder()
            passwordField.resignFirstResponder()
    }
    
}

