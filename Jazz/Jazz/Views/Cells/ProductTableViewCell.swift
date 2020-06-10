//
//  ProductTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/15/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

  @IBOutlet weak var background_view: UIView!
  
  @IBOutlet weak var label_title: UILabel!
  @IBOutlet weak var label_msg: UILabel!
  @IBOutlet weak var label_price: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
