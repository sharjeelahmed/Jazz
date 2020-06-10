//
//  UserProfile.swift
//  Vouch365
//
//  Created by Veer Suthar on 6/6/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

struct UserProfile {
  
  var email:String?
  var fname : String?
  var lname:String?
  var avalink:String?
  
  var pcnt: NSNumber!
  var redcnt: NSNumber!
  var rvcnt: NSNumber!
  var u_vpnts:NSNumber!
  var a_vpnts:NSNumber!
  
  var arrayBadges: NSArray?
  var arrayLevel: NSArray?
  
  var array_badge: Array <Badge> = Array()
  var array_level: Array <Level> = Array()
  
  mutating func setDataFromServer(_ dict: NSDictionary){
    
    print(dict)
    
    email = dict.value(forKey: "email") as? String
    fname = dict.value(forKey: "fname") as? String
    lname = dict.value(forKey: "lname") as? String
    avalink = dict.value(forKey: "avalink") as? String
    
    pcnt = (dict["pcnt"] as! NSString).doubleValue as NSNumber
    redcnt = (dict["redcnt"] as! NSString).doubleValue as NSNumber
    rvcnt = (dict["rvcnt"] as! NSString).doubleValue as NSNumber
    u_vpnts = (dict["u_vpnts"] as! NSString).doubleValue as NSNumber
    a_vpnts = (dict["a_vpnts"] as! NSString).doubleValue as NSNumber

    
    arrayBadges = dict.value(forKey: "badgesData") as? NSArray
    var location = Badge()
    
    if ((arrayBadges?.count)! > 0) {
      for index in 0...(arrayBadges?.count)!-1 {
        location = Badge()
        location.setDataFromServer(dict: (arrayBadges?.object(at: index) as? NSDictionary)!)
        array_badge.append(location)
      }
    }
    
    arrayLevel = dict.value(forKey: "levelsData") as? NSArray
    var voucher = Level()
    
    if ((arrayLevel?.count)! > 0) {
      for index in 0...(arrayLevel?.count)!-1 {
        voucher = Level()
        voucher.setDataFromServer(dict: (arrayLevel?.object(at: index) as? NSDictionary)!)
        array_level.append(voucher)
      }
    }
  }
}
