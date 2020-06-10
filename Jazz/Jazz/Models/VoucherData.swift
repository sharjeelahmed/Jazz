//
//  VoucherData.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/5/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

struct VoucherData{
    
    var vc_ID: String?
    var sp_ID: String?
    var name: String?
    var desc:String?
    var expdate: String?
    var actdate: String?
    var savings: String?
    var status: String?
    var my: String?
    var eligibility:Bool?
    var redeemed:Bool?
    
    mutating func setDataFromServer(location: NSDictionary){
        
        vc_ID = location.value(forKey: "vc_ID") as? String
        sp_ID = location.value(forKey: "sp_ID") as? String
        name = location.value(forKey: "name") as? String
        desc = location.value(forKey: "desc") as? String
        expdate = location.value(forKey: "expdate") as? String
        actdate = location.value(forKey: "actdate") as? String
        savings = location.value(forKey: "savings") as? String
        status = location.value(forKey: "status") as? String
        my = location.value(forKey: "my") as? String
        eligibility = location.value(forKey: "eligibility") as? Bool
        redeemed = location.value(forKey: "redeemed") as? Bool

    }
    
}
