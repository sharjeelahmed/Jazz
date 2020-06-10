//
//  Vouchers.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/18/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

struct Vouchers {
  var vc_ID : String?
  var sp_ID:String?
  var name: String?
  var desc: String?
  var expdate: String?
  var actdate: String?
  var savings: String?
  var redeemed:String?
  var status: String?
  var my: String?
  var monthly: String?
  var new: String?
  var hot: String?
  var premium: String?
  
  mutating func setDataFromServer(dict: NSDictionary){
    vc_ID = dict.value(forKey: "vc_ID") as? String
    sp_ID = dict.value(forKey: "sp_ID") as? String
    name = dict.value(forKey: "name") as? String
    desc = dict.value(forKey: "desc") as? String
    expdate = dict.value(forKey: "expdate") as? String
    actdate = dict.value(forKey: "actdate") as? String
    savings = dict.value(forKey: "savings") as? String
    redeemed = dict.value(forKey: "redeemed") as? String
    status = dict.value(forKey: "status") as? String
    my = dict.value(forKey: "my") as? String
    monthly = dict.value(forKey: "monthly") as? String
    new = dict.value(forKey: "new") as? String
    hot = dict.value(forKey: "hot") as? String
    premium = dict.value(forKey: "premium") as? String
    
  }
}
