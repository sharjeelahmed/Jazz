//
//  LocationTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/25/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

  @IBOutlet weak var label_title: UILabel!
  @IBOutlet weak var label_description: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
