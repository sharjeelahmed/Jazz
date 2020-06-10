//
//  Friend.swift
//  Vouch365
//
//  Created by Veer Suthar on 9/11/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

struct Friend {
  var au_ID: String?
  var email: String?
  var fname: String?
  var lname: String?
  var fr_ID: String?
  var phone: String?
  
  
  mutating func setDataFromServer(dict: NSDictionary){
    
    au_ID = dict.value(forKey: "au_ID") as? String
    email = dict.value(forKey: "email") as? String
    fname = dict.value(forKey: "fname") as? String
    lname = dict.value(forKey: "lname") as? String
    fr_ID = dict.value(forKey: "fr_ID") as? String
    phone = dict.value(forKey: "phone") as? String
  }
}
