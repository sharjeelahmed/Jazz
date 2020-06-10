//
//  UIBarButtonItem.ActionSheetPicker.swift
//  Vouch365
//
//  Created by Veer Suthar on 5/27/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit



let IS_IPHONE = (UI_USER_INTERFACE_IDIOM() == .phone)
let IS_IPAD = (UI_USER_INTERFACE_IDIOM() == .pad)

let SCREEN_WIDTH = (UIScreen.main.bounds.size.width)
let SCREEN_HEIGHT = (UIScreen.main.bounds.size.height)
let SCREEN_MAX_LENGTH = (max(SCREEN_WIDTH, SCREEN_HEIGHT))


let IS_IPHONE_4_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
let IS_IPHONE_5 = (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
let IS_IPHONE_6 = (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
let IS_IPHONE_6P = (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
let IS_IPHONE_X = (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)
let IS_IPAD_PRO = (IS_IPAD && SCREEN_MAX_LENGTH == 1366.0)
let IS_IPAD_NONPRO = (IS_IPAD && SCREEN_MAX_LENGTH == 1024.0)


extension UIBarButtonItem {
  class func doneButton(title: String) -> UIBarButtonItem {
    let btn = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
	btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.appSeafoamBlue], for: .normal)
    return btn
  }
  
  class func cancelButton(title: String) -> UIBarButtonItem {
    let btn = UIBarButtonItem(title: title, style: .done, target: nil, action: nil)
	btn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.appSeafoamBlue], for: .normal)
    return btn
  }
}
