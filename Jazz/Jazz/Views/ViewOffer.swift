//
//  ViewOffer.swift
//  Voucher365
//
//  Created by Veer Suthar on 3/12/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class ViewOffer: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  
  class func instanceFromNib() -> UIView {
    return UINib(nibName: "ViewOffer", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
  }
}
