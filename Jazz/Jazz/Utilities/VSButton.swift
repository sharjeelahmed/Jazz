//
//  VSButton.swift
//  HealthAtHand
//
//  Created by Veer Suthar on 4/5/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit

protocol VSButtonCustomMethods: class {
  func customize()
}

class VSButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    customize()// To set the button color and text size
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    customize()// To set the button color and text size
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    //customize()
  }
}

extension VSButton: VSButtonCustomMethods {
  func customize() {
    var size : CGFloat = 0.0
    let screenSize = UIScreen.main.bounds
    let screenHeight = screenSize.height
    
    switch screenHeight {
    case 480.0:
      size = 72.3/100
    case 568.0:
      size = 85.3/100
    case 667.0:
      size = 1.0
    case 736.0:
      size = 110.5/100
    default: break
    }
    titleLabel?.font = UIFont(name: (titleLabel?.font.fontName)!, size:((titleLabel?.font.pointSize)!)*size)
  }
}
