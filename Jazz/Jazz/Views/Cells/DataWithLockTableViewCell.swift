//
//  DataWithLockTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/16/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class DataWithLockTableViewCell: UITableViewCell {
  
  @IBOutlet weak var label_title: UILabel!
  @IBOutlet weak var textfield_data: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
