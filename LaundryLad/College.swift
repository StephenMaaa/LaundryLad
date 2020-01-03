//
//  College.swift
//  LaundryLad
//
//  Created by Stephen Ma on 1/2/20.
//  Copyright © 2020 Stephen Ma. All rights reserved.
//

import UIKit
 
class College {
    
    //MARK: Properties
    var buildings = [Building]()
    var logo: UIImage?
    var name: String
    
    //MARK: Initialization
    init(name: String, buildings: [Building], logo: UIImage?) {
        self.buildings = buildings
        self.logo = logo
        self.name = name
    }
}

