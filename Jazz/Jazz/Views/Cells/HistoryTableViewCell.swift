//
//  HistoryTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/30/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

  @IBOutlet weak var label_sp_name: UILabel!
  @IBOutlet weak var label_vc_name: UILabel!
  @IBOutlet weak var label_ref_code: UILabel!
  @IBOutlet weak var label_date: UILabel!
  @IBOutlet weak var label_savings: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
