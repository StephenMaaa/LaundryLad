//
//  Machine.swift
//  LaundryLad
//
//  Created by Stephen Ma on 1/2/20.
//  Copyright © 2020 Stephen Ma. All rights reserved.
//

import UIKit
 
class Machine {
    
    //MARK: Properties
    var type: String
    var label: Int
    var status: String
    
    //MARK: Initialization
    init(type: String, label: Int, status: String) {
        self.type = type
        self.label = label
        self.status = status
    }
}

