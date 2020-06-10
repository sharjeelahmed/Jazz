//
//  VSTextField.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/25/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class VSTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

  let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
	return bounds.inset(by: padding)
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
	return bounds.inset(by: padding)
  }
  
  override func editingRect(forBounds bounds: CGRect) -> CGRect {
	return bounds.inset(by: padding)
  }
}
