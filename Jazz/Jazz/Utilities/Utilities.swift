//
//  Utilities.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/24/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation
import MapKit
import Toast_Swift
import CWStatusBarNotification
import Alamofire
import AFViewShaker
import Kingfisher

class Utilities {
  
  class func loadImage(imageView: UIImageView, url: String) {
    let url = URL(string: url)
    imageView.kf.setImage(with: url)
    
  }
  
  class func loadImage(imageView: UIImageView, url: String,imageNamed:String) {
    let url = URL(string: url)
	imageView.kf.setImage(with: url, placeholder:  UIImage(named:imageNamed))
    // imageView.kf.setImage(with: url, placeholder: UIImage(named:imageNamed) , options: nil, progressBlock:nil, completionHandler:nil)
  }
  
  class func shakeTheView(shakeView : UIView){
    let afViewShakerObj = AFViewShaker(view: shakeView)
    afViewShakerObj?.shake()
  }
  
  class func isInternetConnected() -> Bool {
    if NetworkReachabilityManager()!.isReachable {
      return true
    }else {
      Utilities.showStatusBarMessage(message: "No Internet Connection");
      return false
    }
  }
  
  class func showStatusBarMessage(message: String) {
    let notification = CWStatusBarNotification()
    notification.notificationLabelBackgroundColor = UIColor.red
    let duration = TimeInterval(5.0)
    notification.display(withMessage: message, forDuration: duration)
  }

  static let loader_view = GifLoader.instanceFromNib()
  
  static func IfNill(value : String) -> Bool{
    
    return true
  }
  
  
  static func deg2rad(deg:Double) -> Double {
    return deg * Double.pi / 180
  }
  
  ///////////////////////////////////////////////////////////////////////
  ///  This function converts radians to decimal degrees              ///
  ///////////////////////////////////////////////////////////////////////
  static func rad2deg(rad:Double) -> Double {
    return rad * 180.0 / Double.pi
  }
  
  static func getDistanceInKM(lat1:Double, lon1:Double, lat2:Double, lon2:Double, unit:String) -> String {
    let theta = lon1 - lon2
    var dist = sin(deg2rad(deg: lat1)) * sin(deg2rad(deg: lat2)) + cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) * cos(deg2rad(deg: theta))
    dist = acos(dist)
    dist = rad2deg(rad: dist)
    dist = dist * 60 * 1.1515
    if (unit == "K") {
      dist = dist * 1.609344
    }
    else if (unit == "N") {
      dist = dist * 0.8684
    }
    
    
    let doubleStr = String(format: "%.2f KM ", dist) // "3.14"
    return doubleStr
  }
  
  //
  //  static func getDistanceInKM(lat : Double , lon : Double, userLocation : CLLocation) -> String {
  //
  //    print("Your location Lat is \(userLocation.coordinate.latitude)")
  //    print("Your location Lon is \(userLocation.coordinate.longitude)")
  //
  //
  //    let coordinate = CLLocation(latitude:lat, longitude: lon)
  //    let distanceInMeters = coordinate.distance(from: userLocation) * 0.000621371 // result is in km meters
  //    return "\(round(10*distanceInMeters)/10) KM "
  //  }
  //
  static func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
  }
  
  static func showLoader(controller: UIViewController) {
    loader_view.translatesAutoresizingMaskIntoConstraints = false
    controller.view.addSubview(loader_view)
    
	let horizontalConstraint = NSLayoutConstraint(item: loader_view, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: controller.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
    controller.view.addConstraint(horizontalConstraint)
    
	let verticalConstraint = NSLayoutConstraint(item: loader_view, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: controller.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
    controller.view.addConstraint(verticalConstraint)
  }
  
  static func removeLoader() {
    loader_view.removeFromSuperview()
  }
  
  class func convertIphone6ToIphone5_Width(size : CGFloat) -> CGFloat{
    
    /*
     Resize View to thier Canvas area
     */
    
    var tempSize = size;
    
    if UIDevice().userInterfaceIdiom == .phone {
      switch UIScreen.main.bounds.width{
        
        
      case 320:
        // //print("iPhone 4 or 4S")
        tempSize = ( size * 85.3 ) / 100 ;
      case 375:
        ////print("iPhone 5 or 5S or 5C")
        tempSize = ( size * 100 ) / 100 ;
      case 414:
        ////print("iPhone 6 or 6S")
        tempSize = ( size * 110.4 ) / 100 ;
      case 1104:
        // //print("iPhone 6+ or 6S+")
        tempSize = ( size * 110.47 ) / 100 ;
      default: break
        //                //print("", terminator: "")
      }
    }
    else{
      
      switch UIScreen.main.bounds.height {
      case 1024 :
        tempSize = (size * 125) / 100
      case 2732 :
        tempSize = (size * 187) / 100
      default: break
        //                //print("other", terminator: "")
      }
      
      //        1366.0 ipad pro
      //        1024.0
      
      //        1024.0 ipad retina ,2 ,air,air 2
      //        768.0
    }
    
    return tempSize
  }
  
  
  
  class func convertIphone6ToIphone5(size : CGFloat) -> CGFloat{
    
    /*
     Resize View to thier Canvas area
     */
    
    var tempSize = size;
    
    if UIDevice().userInterfaceIdiom == .phone {
      switch UIScreen.main.bounds.height{
        
      case 260:
        ////print("iPhone Classic")
        tempSize = ( size * 72.3 ) / 100 ;
      case 480:
        // //print("iPhone 4 or 4S")
        tempSize = ( size * 72.3 ) / 100 ;
        
      case 568:
        ////print("iPhone 5 or 5S or 5C")
        tempSize = ( size * 85.3 ) / 100 ;
      case 667:
        ////print("iPhone 6 or 6S")
        tempSize = size;
      case 736:
        // //print("iPhone 6+ or 6S+")
        tempSize = ( size * 110.47 ) / 100 ;
        
      /*case 812:
        // //print("iPhone 6+ or 6S+")
        tempSize = ( size * 110.47 ) / 100 ;*/
      default: break
        //                //print("", terminator: "")
      }
    }
    else{
      
      switch UIScreen.main.bounds.height {
      case 1024 :
        tempSize = (size * 125) / 100
      case 2732 :
        tempSize = (size * 187) / 100
      default: break
        //                //print("other", terminator: "")
      }
      
      //        1366.0 ipad pro
      //        1024.0
      
      //        1024.0 ipad retina ,2 ,air,air 2
      //        768.0
    }
    
    return tempSize
  }
  
  class func showToast(error: String, controller: UIViewController) {
    
    // create a new style
    var style = ToastStyle()
    
    // this is just one of many style options
    style.messageColor = UIColor.white
    
    controller.view.makeToast(error, duration: 3.0, position: .center, style: style)
    
    ToastManager.shared.style = style
    
    // toggle "tap to dismiss" functionality
   // ToastManager.shared.tapToDismissEnabled = true
	
	ToastManager.shared.isTapToDismissEnabled = true
    
    // toggle queueing behavior
   // ToastManager.shared.queueEnabled = false
	  ToastManager.shared.isQueueEnabled = false
    
  }
}
