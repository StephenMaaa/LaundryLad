//
//  UniversityTableViewController.swift
//  LaundryLad
//
//  Created by Stephen Ma on 1/2/20.
//  Copyright © 2020 Stephen Ma. All rights reserved.
//

import UIKit
import Firebase

class UniversityTableViewController: UITableViewController {

    //MARK: Properties
    let ref = Database.database().reference()
    var colleges = [College]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref.child("college").observe(.value, with: {snapshot in
            for college in snapshot.children {
                let name = (college as! DataSnapshot).key
                self.colleges.append(College(name: name, logo: UIImage(named: name)))
            }
            self.tableView.reloadData()
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return colleges.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CollegeTableViewCell", for: indexPath) as? CollegeTableViewCell else {
            fatalError("The dequeued cell is not an instance of CollegeTableViewCell.")
        }

        //Configure the cell
        let college = colleges[indexPath.row]
        cell.collegeLogo.image = college.logo
        cell.collegeName.text = college.name
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        guard let destinationController = segue.destination as? BuildingTableViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedCell = sender as? CollegeTableViewCell else {
            fatalError("Unexpected sender: \(sender!)")
        }
        
        guard let selectedIndex = tableView.indexPath(for: selectedCell) else {
            fatalError("Invalid index")
        }
        
        destinationController.collegeName = selectedCell.collegeName.text!
    }
    

}
