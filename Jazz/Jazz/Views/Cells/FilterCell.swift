//
//  FilterCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/8/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit


protocol FilterCellDelegate: class {
    func didTapTick(index: Int, name:String)
}


class FilterCell: UITableViewCell {

    @IBOutlet weak var imageFilterCell: UIImageView!
    @IBOutlet weak var lblFilter: UILabel!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnRight: UIButton!
    
    
    var filterCellDelegate : FilterCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        btnLeft.accessibilityIdentifier = "blackTick"
        btnRight.accessibilityIdentifier = "blackCross"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func didTapOnLeftBtn(_ sender: UIButton) {
        
        
        filterCellDelegate?.didTapTick(index: sender.tag, name:"selected" )
        if btnLeft.accessibilityIdentifier == "blackTick" {
            btnLeft.accessibilityIdentifier = "tick"
            btnLeft.setImage(UIImage(named: "tick"), for: .normal)
            btnRight.accessibilityIdentifier = "blackCross"
            btnRight.setImage(UIImage(named: "blackCross"), for: .normal)
        }
        else {
            btnLeft.accessibilityIdentifier = "blackTick"
            btnLeft.setImage(UIImage(named: "blackTick"), for: .normal)
        }
        //btnRight.setImage(UIImage(named: "cros"), for: .normal)

    }
    
    @IBAction func didTapOnRightBtn(_ sender: UIButton) {
        
        
        filterCellDelegate?.didTapTick(index: sender.tag, name:"unselected" )
        if btnRight.accessibilityIdentifier == "blackCross" {
            btnRight.accessibilityIdentifier = "cros"
            btnRight.setImage(UIImage(named: "cros"), for: .normal)
            btnLeft.setImage(UIImage(named:"blackTick"), for: .normal)
            btnLeft.accessibilityIdentifier = "blackTick"
        }
        else {
            btnRight.accessibilityIdentifier = "blackCross"
            btnRight.setImage(UIImage(named: "blackCross"), for: .normal)
        }
//        btnRight.setImage(UIImage(named: "tick"), for: .normal)
//        btnLeft.setImage(UIImage(named: "cros"), for: .normal)

        
    }
    
}
