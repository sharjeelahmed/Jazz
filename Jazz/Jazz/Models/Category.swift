//
//  Category.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/27/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

struct Category{
  
  var city :String!
  var latitude : String!
  var locality: String!
  var logo : String!
  var longitude : String!
  var name : String!
  var sp_ID : String!
  var state : String!
  var header : String!
  var discount : String!

	

  
  mutating func setDataFromServer(dict: NSDictionary){
    city = dict.value(forKey: "city") as! String
    latitude = dict.value(forKey: "latitude") as! String
    locality = dict.value(forKey: "locality") as! String
    locality = dict.value(forKey: "locality") as! String
    logo = dict.value(forKey: "logo") as! String
    longitude = dict.value(forKey: "longitude") as! String
    name = dict.value(forKey: "name") as! String
    sp_ID = dict.value(forKey: "sp_ID") as! String
    state = dict.value(forKey: "state") as! String
	header = dict.value(forKey: "header") as! String
    discount = dict.value(forKey: "discount") as! String
  }
}

struct ShowCategory{
  static var body = "body"
  static var kids = "kids"
  static var leisure = "leisure"
  static var restaurant = "restaurant"
  static var services = "services"
  static var travel = "travel"
}
