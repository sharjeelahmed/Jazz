//
//  PING.swift
//  Vouch365
//
//  Created by MacBook Pro on 18/04/2018.
//  Copyright © 2018 Veer Suthar. All rights reserved.
//

import Foundation
struct Ping {
    
    var sp_ID:String?
    var name : String?
    var locality: String?
    var logo: String?
    var category : String?
    var longitude:String?
    var latitude: String?
    var state: String?
    var city: String?
    var pingdesc: String?


    
    mutating func setDataFromServer(dict: NSDictionary){
        
        sp_ID = dict.value(forKey: "sp_ID") as? String
        name = dict.value(forKey: "name") as? String
        locality = dict.value(forKey: "locality") as? String
        logo = dict.value(forKey: "logo") as? String
        category = dict.value(forKey: "category") as? String
        longitude = dict.value(forKey: "longitude") as? String
        latitude = dict.value(forKey: "latitude") as? String
        state = dict.value(forKey: "state") as? String
        city = dict.value(forKey: "city") as? String
        pingdesc = dict.value(forKey: "pingdesc") as? String

        
        

        
    }
}
