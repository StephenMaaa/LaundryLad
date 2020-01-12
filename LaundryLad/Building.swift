//
//  Building.swift
//  LaundryLad
//
//  Created by Stephen Ma on 1/2/20.
//  Copyright © 2020 Stephen Ma. All rights reserved.
//

import UIKit
 
class Building {
    
    //MARK: Properties
    //var machines = [Machine]()
    var location: String
    var name: String
    
    //MARK: Initialization
    init(name: String, location: String) {
        self.name = name
        //self.machines = machines
        self.location = location
    }
}

