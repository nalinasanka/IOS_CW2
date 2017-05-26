//
//  LoginViewController.swift
//  IOS_TicketBookingSystem
//
//  Created by Nalin Jayasekera on 5/20/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        let adminTab = self.storyboard?.instantiateViewController(withIdentifier: "AdminTabBar") as! UITabBarController
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = adminTab
        
    }
    
    
}
