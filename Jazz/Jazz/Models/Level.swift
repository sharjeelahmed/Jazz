//
//  Level.swift
//  Vouch365
//
//  Created by Veer Suthar on 6/6/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

struct Level {
  
  var active:Int?
  var desc : String?
  var id:Int?
  var image: String?
  var name: String?
  var required: Int?
  
  mutating func setDataFromServer(dict: NSDictionary){
    
    active = dict.value(forKey: "active") as? Int
    desc = dict.value(forKey: "desc") as? String
    id = dict.value(forKey: "id") as? Int
    image = dict.value(forKey: "image") as? String
    name = dict.value(forKey: "name") as? String
    required = dict.value(forKey: "required") as? Int
  }
}
