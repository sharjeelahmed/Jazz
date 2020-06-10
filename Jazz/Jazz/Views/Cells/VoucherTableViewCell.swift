//
//  VoucherTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/6/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

protocol VoucherDelegate: class {
  func didSelectVoucher(index: Int)
}

class VoucherTableViewCell: UITableViewCell {
  
  weak var delegate:VoucherDelegate?
  
  @IBOutlet weak var imageview_voucher: UIImageView!
  @IBOutlet weak var label_title: UILabel!
  @IBOutlet weak var label_description: UILabel!
  @IBOutlet weak var button_checkbox: UIButton!
  
  @IBAction func didSelectVoucher(_ sender: UIButton) {
    delegate?.didSelectVoucher(index: sender.tag)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
