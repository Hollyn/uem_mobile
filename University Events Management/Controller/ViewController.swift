//
//  ViewController.swift
//  University Events Management
//
//  Created by Hollyn Derisse on 6/15/19.
//  Copyright © 2019 Hollyn Derisse. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    // constants
    let constants = Constants()
    
    // properties
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func loadView() {
        super.loadView()
        
        // check if user is already logged in
        if constants.defaults.bool(forKey: constants.IS_USER_LOGGED_IN) {
            goToHome(animation: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // actions
    
    @IBAction func loginPressed(_ sender: Any) {
        
        let email = emailField.text
        let password = passwordField.text
        
        if validation(email: email!, password: password!) {
            let params : [String : String] = ["email" : email!, "password" : password!]
            
            authenticate(url: constants.API_URL + constants.LOGIN_URL, params: params)
            
            emailField.text = ""
            passwordField.text = ""
        } else {
            print("Authentication problem")
        }
    }
    
    
    @IBAction func bgOutside(_ sender: UITapGestureRecognizer) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
    }
    
    
    // MARK: - NETWORK
    func authenticate(url: String, params: [String : String]){
        Alamofire.request(url, method: .post, parameters: params).responseJSON{
            response in
            if response.result.isSuccess {
                // code
                let json = JSON(response.result.value!)
                
                guard let rawData = try? json.rawData() else {return}
                
                
                self.constants.defaults.set(rawData, forKey: self.constants.USER_DATA)
                self.constants.defaults.set(true, forKey: self.constants.IS_USER_LOGGED_IN)
                self.goToHome(animation: true)
                
                print(self.constants.defaults.string(forKey: self.constants.USER_DATA) ?? "")
            } else {
                print("There's a problem")
            }
        }
    }
    
    
    // MARK: - VALIDATION
    func validation(email: String, password: String) -> Bool {
        var isEmailOk = false
        
        if email.count == 0 || password.count == 0{
            return false
        } else {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            isEmailOk = emailTest.evaluate(with: email)
            
            if !isEmailOk {
                return false
            }
            if password.count < 8 {
                return false
            }
        }
        
        return true
    }
    
    // MARK: - JSON PARSING
    
    // go to Home View
    func goToHome(animation: Bool){
        let homeVC =
            self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(homeVC, animated: animation)

    }
}

