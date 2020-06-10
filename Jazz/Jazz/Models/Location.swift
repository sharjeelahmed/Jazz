//
//  Location.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/5/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

struct Location{
  
  var sp_ID: String?
  var locality:String?
  var city: String?
  var latitude: String?
  var longitude: String?
  var locations: String?
  
  mutating func setDataFromServer(location: NSDictionary){
    sp_ID = location.value(forKey: "sp_ID") as? String
    locality = location.value(forKey: "locality") as? String
    city = location.value(forKey: "city") as? String
    latitude = location.value(forKey: "latitude") as? String
    longitude = location.value(forKey: "longitude") as? String
    locations = location.value(forKey: "locations") as? String
  }
  
}
