//
//  TableForCheckInUsers.swift
//  Pawsome Time
//
//  Created by kwangi yu on 12/9/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
// custom table view cell 
class TableForCheckInUsers: UITableViewCell {
    
    
    @IBOutlet var size: UILabel!
    @IBOutlet var breed: UILabel!
    
    @IBOutlet var birth: UILabel!
    @IBOutlet var Personality: UILabel!
    @IBOutlet var dogName: UILabel!
 
 
    @IBOutlet var ProfilePhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
