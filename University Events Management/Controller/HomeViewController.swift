//
//  HomeViewController.swift
//  University Events Management
//
//  Created by Hollyn Derisse on 6/16/19.
//  Copyright © 2019 Hollyn Derisse. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController {
    let constants = Constants()
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let data = self.constants.defaults.value(forKey: self.constants.USER_DATA)  as? Data else { return }
        
        let USER_DATA_JSON = JSON(data)
        
        nameLabel.text = USER_DATA_JSON["user"]["firstname"].stringValue

        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func buttonLogout(_ sender: Any) {
        constants.defaults.set(false, forKey: constants.IS_USER_LOGGED_IN)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
