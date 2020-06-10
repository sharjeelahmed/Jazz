//
//  FilterSimpleCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/8/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class FilterSimpleCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
