//
//  ViewController.swift
//  IOS_TicketBookingSystem
//
//  Created by Nalin Jayasekera on 4/19/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit

class StudentDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        
        let isPresentingInAddContactMode = presentingViewController is UINavigationController
        
        if isPresentingInAddContactMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The StudentDetailViewController is not inside a navigation controller.")
        }
    }

}

