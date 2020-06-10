


//
//  CompanyDescriptionTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/7/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class CompanyDescriptionTableViewCell: UITableViewCell {
  
  @IBOutlet weak var label_description: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
    @IBOutlet weak var seeMoreBtn: UIButton!
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  @IBAction func didHeightButtonPressed(_ sender: UIButton) {
    
  }
  
}
