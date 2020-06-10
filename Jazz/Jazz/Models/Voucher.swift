//
//  Voucher.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/26/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

struct Voucher {
  
  var cat : String?
  var header:String?
  var id: String?
  var linktype: String?
  var logo: String?
  var sdid: String?
  var spid: String?
  var redeemed:String?
  var tab: String?
  var tag: String?
  var monthly: String?
  var url: String?
  
  static func getArrayOfVoucher(array: Array<Dictionary<String, Any>>) -> Array<Voucher>{
    var list: Array<Voucher> = []
    var voucher: Voucher = Voucher()
    for json in array {
      //voucher.id  =  (json["channel_id"] as? Int) ?? 0
      voucher.cat = (json["cat"] as? String) ?? ""
      voucher.header = (json["header"] as? String) ?? ""
      voucher.id = (json["id"] as? String) ?? ""
      voucher.linktype = (json["linktype"] as? String) ?? ""
      voucher.logo = (json["logo"] as? String) ?? ""
      voucher.sdid = (json["sdid"] as? String) ?? ""
      voucher.spid = (json["spid"] as? String) ?? ""
      voucher.redeemed = (json["redeemed"] as? String) ?? ""
      voucher.tab = (json["tab"] as? String) ?? ""
      voucher.tag = (json["tag"] as? String) ?? ""
      voucher.monthly = (json["monthly"] as? String) ?? ""
      voucher.url = (json["url"] as? String) ?? ""

      list.append(voucher)
    }
    return list
  }
}

