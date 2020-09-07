//
//  CheckInViewCell.swift
//  Pawsome Time
//
//  Created by kwangi yu on 12/8/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
//custom view cell for check in
class CheckInViewCell: UITableViewCell {
    // variables for map, detial loacation, name 
    @IBOutlet var Map: UILabel!
    @IBOutlet var Detail: UILabel!
    @IBOutlet var Location: UILabel!
    @IBOutlet var Name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
