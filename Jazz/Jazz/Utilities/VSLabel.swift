//
//  VSLabel.swift
//  HealthAtHand
//
//  Created by Veer Suthar on 4/5/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit

protocol VSLabelCustomMethods: class {
  func customize()
}

class VSLabel: UILabel {
  
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


extension VSLabel: VSLabelCustomMethods {
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
      
    case 1024 :
      size = (size * 125) / 100
    case 2732 :
      size = (size * 187) / 100

    default: break
    }
    
    self.font = UIFont(name: (self.font.fontName), size:((self.font.pointSize))*size)
  }
}

extension String {
  
  
  func addLineSpaing(srtingIs : String, lineSpacing:Int) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: srtingIs)
    
    // *** Create instance of `NSMutableParagraphStyle`
    let paragraphStyle = NSMutableParagraphStyle()
     paragraphStyle.alignment = .center
    // *** set LineSpacing property in points ***
    paragraphStyle.lineSpacing = 6 // Whatever line spacing you want in points
    //    paragraphStyle.maximumLineHeight = 24
    // *** Apply attribute to string ***
	attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
    
    // *** Set Attributed String to your label ***
    return  attributedString;
  }

  
  

}













