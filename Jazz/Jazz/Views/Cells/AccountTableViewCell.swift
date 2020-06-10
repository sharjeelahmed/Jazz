//
//  AccountTableViewCell.swift
//  Voucher365
//
//  Created by Veer Suthar on 3/12/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
  
  @IBOutlet weak var label_title: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  @IBAction func button_pressed(_ sender: UIButton) {
    
  }
  
  /*
/** adds a drop shadow to the background view of the (grouped) cell */
func addShadowToCell(in tableView: UITableView, at indexPath: IndexPath) {
    var isFirstRow: Bool = !indexPath.row
    var isLastRow: Bool = (indexPath.row == tableView.numberOfRows(in section: indexPath.section) - 1)
        // the shadow rect determines the area in which the shadow gets drawn
    var shadowRect: CGRect = self.backgroundView.bounds.insetBy(dx: CGFloat(0), dy: CGFloat(-10))
    if isFirstRow {
        shadowRect.origin.y += 10
    }
    else if isLastRow {
        shadowRect.size.height -= 10
    }
        // the mask rect ensures that the shadow doesn't bleed into other table cells
    var maskRect: CGRect = self.backgroundView.bounds.insetBy(dx: CGFloat(-20), dy: CGFloat(0))
    if isFirstRow {
        maskRect.origin.y -= 10
        maskRect.size.height += 10
    }
    else if isLastRow {
        maskRect.size.height += 10
    }
        // now configure the background view layer with the shadow
    var layer: CALayer? = self.backgroundView.layer
    layer?.shadowColor = UIColor.red.cgColor
    layer?.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(0))
    layer?.shadowRadius = 3
    layer?.shadowOpacity = 0.75
    layer?.shadowPath = UIBezierPath(roundedRect: shadowRect, cornerRadius: 5).cgPath
    layer?.masksToBounds = false
        // and finally add the shadow mask
    var maskLayer = CAShapeLayer()
    maskLayer.path = UIBezierPath(rect: maskRect).cgPath
    layer?.mask = maskLayer
}
 
 */
}
