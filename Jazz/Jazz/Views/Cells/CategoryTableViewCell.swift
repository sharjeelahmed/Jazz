//
//  CategoryTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/27/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

  @IBOutlet weak var label_title: UILabel!
  @IBOutlet weak var imageview_logo: UIImageView!
  @IBOutlet weak var label_location: UILabel!
  @IBOutlet weak var label_distance: UILabel!
    @IBOutlet weak var small_icon: UIImageView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
