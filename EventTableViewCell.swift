//
//  EventTableViewCell.swift
//  IOS_TicketBookingSystem
//
//  Created by Nalin Jayasekera on 5/22/17.
//  Copyright © 2017 MyOrganization. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventNameLabel: UILabel!    
    @IBOutlet weak var eventPlaceImageView: UIImageView!
    @IBOutlet weak var eventPlaceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
