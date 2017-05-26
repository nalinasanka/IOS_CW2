//
//  EventTableViewController.swift
//  IOS_TicketBookingSystem
//
//  Created by Nalin Jayasekera on 5/22/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit
import os.log

class EventTableViewController: UITableViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        if let savedEvents = loadEvents() {
            events += savedEvents
        }
        else {
            loadSampleEvents()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "EventTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell
            else {
                fatalError("The dequeued call is not an instance of EventTableViewCell.")
        }

        let event = events[indexPath.row]
        
        cell.eventNameLabel.text = event.name
        cell.eventPlaceLabel.text = event.place
        cell.eventPlaceImageView.image = event.photo
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            events.remove(at: indexPath.row)
            saveEvents()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        let isPresentingInAddContactMode = presentingViewController is UINavigationController
        
        if isPresentingInAddContactMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The PersonViewController is not inside a navigation controller.")
        }
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "AddEvent":
            os_log("Adding a new event.",log: OSLog.default, type: .debug)
        case "ShowEventDetail":
            guard let eventDetailViewController = segue.destination as? EventDetailViewController
                else{
                    fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedEventCell = sender as? EventTableViewCell
                else {
                    fatalError("Unexpecetd sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedEventCell)
                else {
                    fatalError("The selected cell is not being dispalyed by the table.")
            }
            
            let selectedEvent = events[indexPath.row]
            eventDetailViewController.event = selectedEvent
        default:
            fatalError("Unexpected Segue Identifier: \(segue.identifier)")
        }
        
    }
    
    private func loadEvents() -> [Event]? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: Event.ArchiveURL.path) as? [Event]
    }
    
    private func saveEvents() {
        
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(events, toFile: Event.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Contacts successfully saved.",log: OSLog.default, type: .debug)
        }
        else {
            os_log("Failed to save contacts...", log:OSLog.default, type: .error)
        }
    }
 
    @IBAction func unwindToEventList(sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.source as? EventDetailViewController,let event = sourceViewController.event{
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //update an existing contact
                events[selectedIndexPath.row] = event
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new contact
                let newIndexPath = IndexPath(row: events.count, section: 0)
                events.append(event)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            saveEvents()
        }
    }

    private func loadSampleEvents()
    {
        let photo1 = UIImage(named: "TheaterIcon")
        
        guard let event1 = Event(eventName: "Stagecraft at Nelum Pokuna", eventPhoto:photo1, eventPlace: "Colombo 2")
            else {
                fatalError("Unable to instantiate event")
        }
        
        guard let event2 = Event(eventName: "Talent show at BMICH", eventPhoto:photo1, eventPlace: "Colombo 7")
            else {
                fatalError("Unable to instantiate event")
        }
        
        events += [event1, event2]
    }
}
