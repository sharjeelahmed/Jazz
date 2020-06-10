//
//  OfferedInProductTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/8/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class OfferedInProductTableViewCell: UITableViewCell {

  @IBOutlet weak var label_offer: UILabel!
  @IBOutlet weak var label_title: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
