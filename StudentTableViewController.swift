//
//  StudentTableViewController.swift
//  IOS_TicketBookingSystem
//
//  Created by Nalin Jayasekera on 5/20/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController,UINavigationControllerDelegate {
    
    var students = [Student]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleStudents()
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return students.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "StudentTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? StudentTableViewCell
        else {
            fatalError("The dequeued call is not an instance of StudentTableViewCell.")
        }

        let student = students[indexPath.row]
        
        cell.studentNameLabel.text = student.name
        cell.studentPhoto.image = student.photo

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    private func loadSampleStudents()
    {
        let photo1 = UIImage(named: "male_gender")
        let photo2 = UIImage(named: "male_gender")
        
        guard let student1 = Student(studentName: "Duminda Jayasinghe", studentPhoto:photo1)
            else {
                fatalError("Unable to instantiate contact")
        }
        
        guard let student2 = Student(studentName: "Nalin Jayasekera", studentPhoto:photo2)
            else {
                fatalError("Unable to instantiate contact")
        }
        
        students += [student1, student2]
    }
    
}
