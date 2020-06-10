//
//  SelectionTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/24/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit


protocol SelectionCellDelegate: class {
  func didTapTick(index: Int)
}

class SelectionTableViewCell: UITableViewCell {
  
  weak var selectionDelegate:SelectionCellDelegate?
  @IBOutlet weak var image_cityIcon: UIImageView!
  @IBOutlet weak var label_name: UILabel!
  @IBOutlet weak var button_tick: UIButton!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  @IBAction func tickIsPressed(_ sender: UIButton) {
    print("Tick is clicked")
    User.setSelectedBtn(tag: sender.tag)
    button_tick.setImage(UIImage(named: "check"), for: .normal)
    selectionDelegate?.didTapTick(index:sender.tag)
  }
}
