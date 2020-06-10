//
//  Badge.swift
//  Vouch365
//
//  Created by Veer Suthar on 6/6/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

/*
 
 active = 0;
 desc = "How much have you saved? Share your savings on social media and earn this badge";
 id = 1;
 image = "http://secapibeta.vouch365.mobi/uploads/bdg/1_inactive.png";
 name = "Brag and Tag";
 
 */

struct Badge {
  
  var active:Int?
  var desc : String?
  var id:Int?
  var image: String?
  var name: String?
  
  mutating func setDataFromServer(dict: NSDictionary){
    
    active = dict.value(forKey: "active") as? Int
    desc = dict.value(forKey: "desc") as? String
    id = dict.value(forKey: "id") as? Int
    image = dict.value(forKey: "image") as? String
    name = dict.value(forKey: "name") as? String
  }
}
