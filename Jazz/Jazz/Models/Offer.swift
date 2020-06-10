//
//  Offer.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/19/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

struct Offer {
  
  var sp_ID:String?
  var name : String?
  var desc:String?
  var locality: String?
  var number: String?
  var logo: String?
  var header:String?
  var offertype:String?
  var category : String?
  var locations:String?
  var longitude:String?
  var latitude: String?
  var state: String?
  
  mutating func setDataFromServer(dict: NSDictionary){
    
    sp_ID = dict.value(forKey: "sp_ID") as? String
    name = dict.value(forKey: "name") as? String
    desc = dict.value(forKey: "desc") as? String
    locality = dict.value(forKey: "locality") as? String
    number = dict.value(forKey: "number") as? String
    logo = dict.value(forKey: "logo") as? String
    header = dict.value(forKey: "header") as? String
    offertype = dict.value(forKey: "offertype") as? String
    category = dict.value(forKey: "category") as? String
    locations = dict.value(forKey: "locations") as? String
    longitude = dict.value(forKey: "longitude") as? String
    latitude = dict.value(forKey: "latitude") as? String
    state = dict.value(forKey: "state") as? String
  }
}
