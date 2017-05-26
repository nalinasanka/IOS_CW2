//
//  EventDetailViewController.swift
//  IOS_TicketBookingSystem
//
//  Created by Nalin Jayasekera on 5/23/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit
import os.log

class EventDetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        eventNameTextField.delegate = self
        placeTextField.delegate = self
        
        if let event = event {            
            navigationItem.title = event.name
            eventNameTextField.text = event.name
            placeTextField.text = event.place
        }
        updateSaveButtonState()
    }

    /*override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    
    func  textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        updateSaveButtonState()
        navigationItem.title = eventNameTextField.text
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateSaveButtonState()
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
            fatalError("The EventDetailViewController is not inside a navigation controller.")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton
            else {
                os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
                return
        }
        
        let name = eventNameTextField.text ?? ""
        let place = placeTextField.text ?? ""
        
        event = Event(eventName: name, eventPhoto: nil, eventPlace: place)
        
    }
    
    private func updateSaveButtonState() {
        
        let nameText = eventNameTextField.text ?? ""
        let placeText = placeTextField.text ?? ""
        saveButton.isEnabled = !nameText.isEmpty && !placeText.isEmpty
    }

}
