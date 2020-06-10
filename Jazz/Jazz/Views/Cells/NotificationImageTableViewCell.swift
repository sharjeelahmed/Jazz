//
//  NotificationImageTableViewCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/15/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

protocol NotificationImageTableViewCellProtocol {
    
    func btnPressed(indexpath:IndexPath)
}

class NotificationImageTableViewCell: UITableViewCell {

    @IBOutlet weak var readmore_lbl: UILabel!
    @IBOutlet weak var btn_nav: UIButton!

    @IBOutlet weak var lbl_desc: UILabel!
    @IBOutlet weak var corner_img: UIImageView!
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var banner_image: UIImageView!
    var delegate:NotificationImageTableViewCellProtocol!
    var indexPath:IndexPath!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func BtnPressed(_ sender:UIButton){
        
        delegate.btnPressed(indexpath: self.indexPath)
    }

}
