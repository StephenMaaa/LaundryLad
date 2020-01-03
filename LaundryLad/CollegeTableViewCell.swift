//
//  CollegeTableViewCell.swift
//  LaundryLad
//
//  Created by Stephen Ma on 1/2/20.
//  Copyright © 2020 Stephen Ma. All rights reserved.
//

import UIKit

class CollegeTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var collegeLogo: UIImageView!
    @IBOutlet weak var collegeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
