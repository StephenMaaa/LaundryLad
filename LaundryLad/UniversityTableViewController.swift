//
//  UniversityTableViewController.swift
//  LaundryLad
//
//  Created by Stephen Ma on 1/2/20.
//  Copyright © 2020 Stephen Ma. All rights reserved.
//

import UIKit

class UniversityTableViewController: UITableViewController {

    //MARK: Properties
    var colleges = [College]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        load()
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
    

    //MARK: Private Methods
    private func load() {
        let machine1 = Machine(type: "Washer", label: 1, status: "Working")
        let machine2 = Machine(type: "Washer", label: 2, status: "Available")
        let machine3 = Machine(type: "Dryer", label: 3, status: "Working")
        let machine4 = Machine(type: "Dryer", label: 4, status: "Available")
        var machines = [Machine]()
        machines += [machine1, machine2, machine3, machine4]
        
        let warrenBuildings = [Building(name: "Bates Hall", machines: machines, location: "32.884153, -117.232144"), Building(name: "Douglas Hall", machines: machines, location: "32.883401, -117.232913")]
        let warren = College(name: "Warren", buildings: warrenBuildings, logo: UIImage(named: "Warren"))
        
        let ercBuildings = [Building(name: "Asia Hall", machines: machines, location: "N/A"), Building(name: "Oceania Hall", machines: machines, location: "N/A"), Building(name: "Geneva Hall", machines: machines, location: "N/A")]
        let erc = College(name: "ERC", buildings: ercBuildings, logo: UIImage(named: "ERC"))
        
        let revelleBuildings = [Building(name: "Argo Hall", machines: machines, location: "N/A"), Building(name: "Blaker Hall", machines: machines, location: "N/A"), Building(name: "Challenger Hall", machines: machines, location: "N/A")]
        let revelle = College(name: "Revelle", buildings: revelleBuildings, logo: UIImage(named: "Revelle"))
        
        let muirBuildings = [Building(name: "Tenaya Hall", machines: machines, location: "N/A"), Building(name: "Tioga Hall", machines: machines, location: "N/A"), Building(name: "Tuolumne Hall", machines: machines, location: "N/A")]
        let muir = College(name: "Muir", buildings: muirBuildings, logo: UIImage(named: "Muir"))
        
        let marshallBuildings = [Building(name: "Apartment 1", machines: machines, location: "N/A"), Building(name: "Apartment 2", machines: machines, location: "N/A"), Building(name: "Apartment 3", machines: machines, location: "N/A")]
        let marshall = College(name: "Marshall", buildings: marshallBuildings, logo: UIImage(named: "Marshall"))
        
        let sixthBuildings = [Building(name: "Matthews Hall", machines: machines, location: "N/A"), Building(name: "Apartment 1", machines: machines, location: "N/A"), Building(name: "Residence Hall 1", machines: machines, location: "N/A")]
        let sixth = College(name: "Sixth", buildings: sixthBuildings, logo: UIImage(named: "Sixth"))
        
        colleges += [warren, erc, revelle, muir, marshall, sixth]
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
        destinationController.buildings = colleges[selectedIndex.row].buildings
    }
    

}
