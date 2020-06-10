//
//  HomeTableViewCell.swift
//  ActionSheetPicker-3.0
//
//  Created by Shairjeel Ahmed on 01/05/2020.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
	
	@IBOutlet weak var label_title: UILabel!
	@IBOutlet weak var label_Location: UILabel!
	@IBOutlet weak var imageview_logo: UIImageView!
	@IBOutlet weak var small_icon: UIImageView!
	@IBOutlet weak var label_voucherName: UILabel!
	@IBOutlet weak var label_Date: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
