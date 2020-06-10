//
//  NotificationTextTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/15/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class NotificationTextTableViewCell: UITableViewCell {
    @IBOutlet weak var notif_title: UILabel!
    @IBOutlet weak var joinuslbl: UILabel!

    @IBOutlet weak var cell_image: UIImageView!
    @IBOutlet weak var detail_lbl: UILabel!
    @IBOutlet weak var corner_image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
