//
//  FavouriteTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/19/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit

class FavouriteTableViewCell: UITableViewCell {
  
  @IBOutlet weak var imageview_logo: UIImageView!
  @IBOutlet weak var imageview_icon: UIImageView!
  @IBOutlet weak var label_name: UILabel!
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
