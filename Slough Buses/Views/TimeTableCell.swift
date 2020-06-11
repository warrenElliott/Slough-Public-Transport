//
//  TimeTableCell.swift
//  Slough Public Transport
//
//  Created by Warren Elliott on 27/05/2020.
//  Copyright © 2020 Warren Elliott. All rights reserved.
//

import UIKit

class TimeTableCell: UITableViewCell {
    
    @IBOutlet weak var busRouteLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
