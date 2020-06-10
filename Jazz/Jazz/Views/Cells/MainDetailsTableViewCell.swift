//
//  MainDetailsTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/27/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class MainDetailsTableViewCell: UITableViewCell {
  
  @IBOutlet weak var label_name: UILabel!
  @IBOutlet weak var label_type: UILabel!
  @IBOutlet weak var label_distance: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
