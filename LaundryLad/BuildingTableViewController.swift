//
//  BuildingTableViewController.swift
//  LaundryLad
//
//  Created by Stephen Ma on 1/2/20.
//  Copyright © 2020 Stephen Ma. All rights reserved.
//

import UIKit
import Firebase

class BuildingTableViewController: UITableViewController {

    //MARK: Properties
    let buildingRef = Database.database().reference(withPath: "college")
    var collegeName: String = ""
    var buildings = [Building]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildingRef.child(collegeName).child("building").observe(.value, with: {snapshot in
            for building in snapshot.children {
                let buildingSnapshot = building as! DataSnapshot
                let name = buildingSnapshot.key
                let value = buildingSnapshot.value as! NSDictionary
                let location = value["location"] as! String
                self.buildings.append(Building(name: name, location: location))
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
        return buildings.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BuildingTableViewCell", for: indexPath) as? BuildingTableViewCell else {
            fatalError("The dequeued cell is not an instance of BuildingTableViewCell.")
        }

        //Configure the cell
        let building = buildings[indexPath.row]
        cell.buildingName.text = building.name
        cell.mapButton.tag = indexPath.row
        //let googleMap = UIImage(named: "GoogleMap")
        //cell.mapButton.setImage(googleMap, for: .normal)
        
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
        switch segue.identifier {
        case "showMapView":
            guard let destinationController = segue.destination as? ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let button = sender as? UIButton else {
                fatalError("Unexpected sender: \(sender!)")
            }
            
            let building = buildings[button.tag]
            destinationController.collegeName = collegeName
            destinationController.buildingName = building.name
            destinationController.coordinate = building.location
        case "showMachines":
            guard let destinationController = segue.destination as? MachineCollectionViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedCell = sender as? BuildingTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            guard let selectedIndex = tableView.indexPath(for: selectedCell) else {
                fatalError("Invalid index")
            }
            
            let building = buildings[selectedIndex.row]
            destinationController.collegeName = collegeName
            destinationController.buildingName = building.name
        default:
            fatalError("Unexpected segue")
        }
    }
    

}
