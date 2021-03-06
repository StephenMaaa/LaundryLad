//
//  MachineCollectionViewController.swift
//  LaundryLad
//
//  Created by Stephen Ma on 1/3/20.
//  Copyright © 2020 Stephen Ma. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "MachineCollectionViewCell"

class MachineCollectionViewController: UICollectionViewController {

    //MARK: Properties
    let machineRef = Database.database().reference(withPath: "college")
    var collegeName: String = ""
    var buildingName: String = ""
    var machines = [Machine]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //retrieve data from Firebase database
    machineRef.child(collegeName).child("building").child(buildingName).child("machines").queryOrdered(byChild: "label").observe(.value, with: {snapshot in
            for machine in snapshot.children {
                let machineSnapshot = machine as! DataSnapshot
                let name = machineSnapshot.key
                let index = name.firstIndex(of: " ")
                let typeIndex = name.index(before: index!)
                let type = name[...typeIndex]
                let dic = machineSnapshot.value as! NSDictionary
                self.machines.append(Machine(type: String(type), label: dic.value(forKey: "label") as! Int, status: dic.value(forKey: "status") as! String))
            }
            self.collectionView.reloadData()
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return machines.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MachineCollectionViewCell else {
            fatalError("The dequeued cell is not an instance of MachineCollectionViewCell.")
        }
        
        //Configure the cell
        let machine = machines[indexPath.row]
        if machine.type == "Washer" {
            cell.machineImage.image = UIImage(named: "Washer")
        } else {
            cell.machineImage.image = UIImage(named: "Dryer")
        }
        cell.machineName.text = machine.type + " #" + "\(machine.label)"
        cell.machineStatus.text = machine.status
        if machine.status == "Working" {
            cell.machineStatus.backgroundColor = UIColor.red
        } else {
            cell.machineStatus.backgroundColor = UIColor.green
        }
        
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 1
            
        return cell

    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
