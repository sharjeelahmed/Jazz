//
//  PingTableViewCell.swift
//  Vouch365
//
//  Created by MacBook Pro on 18/04/2018.
//  Copyright © 2018 Veer Suthar. All rights reserved.
//

import UIKit

class PingTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageview_logo: UIImageView!
    @IBOutlet weak var imageview_icon: UIImageView!
    @IBOutlet weak var label_name: UILabel!
    @IBOutlet weak var label_locality: UILabel!
    @IBOutlet weak var label_pingdesc: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
