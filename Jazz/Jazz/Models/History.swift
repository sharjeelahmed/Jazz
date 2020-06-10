//
//  History.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/30/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

import Foundation

struct History {
  
  var r_ID: String?
  var au_ID: String?
  var vc_ID: String?
  var sp_ID:String?
  var c_ID: String?
  var date: String?
  var time: String?
  var savings: String?
  var ref_code: String?
  var sp_name:String?
  var vc_name:String?
  
  static func getArrayOfHistory(array: Array<Dictionary<String, Any>>) -> Array<History>{
    var list: Array<History> = []
    var history: History = History()
    for json in array {
      history.r_ID  =  (json["r_ID"] as? String) ?? ""
      history.au_ID  =  (json["au_ID"] as? String) ?? ""
      history.vc_ID  =  (json["vc_ID"] as? String) ?? ""
      history.sp_ID  =  (json["sp_ID"] as? String) ?? ""
      history.date  =  (json["date"] as? String) ?? ""
      history.time  =  (json["time"] as? String) ?? ""
      history.savings  =  (json["savings"] as? String) ?? ""
      history.ref_code  =  (json["ref_code"] as? String) ?? ""
      history.sp_name  =  (json["sp_name"] as? String) ?? ""
      history.vc_name  =  (json["vc_name"] as? String) ?? ""
      list.append(history)
    }
    return list
  }
}

