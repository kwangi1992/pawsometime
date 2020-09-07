//
//  TableViewCell.swift
//  Pawsome Time
//
//  Created by kwangi yu on 12/8/19.
//  Copyright © 2019 nyu.edu. All rights reserved.
//

import UIKit
// custom table view cell
class TableViewCell: UITableViewCell {

  
    @IBOutlet var EventDetail: UILabel!
    @IBOutlet var EventLocation: UILabel!
    @IBOutlet var EventName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
