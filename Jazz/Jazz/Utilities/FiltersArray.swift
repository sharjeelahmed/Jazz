//
//  FiltersArray.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/26/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit
class FiltersArray {
  
  static func foodAndRestaurants() -> Array<KeyValue> {
    var array : Array<KeyValue> = Array<KeyValue>()
    
  /*  array.append(KeyValue(key: "bakery",value: "Bakery",image: UIImage()))
    array.append(KeyValue(key: "brunch",value: "Brunch",image: UIImage(named:"Brunch")!))
    array.append(KeyValue(key: "buffet",value: "Buffet", image : UIImage(named:"Buffet")!))
    array.append(KeyValue(key: "delivery",value: "Delivery", image : UIImage()))
    array.append(KeyValue(key: "groups",value: "Groups Welcome", image : UIImage(named:"Groups_welcome")!))
    array.append(KeyValue(key: "halal",value: "Halal", image : UIImage(named:"Halal")!))
    array.append(KeyValue(key: "kids",value: "Kids Welcome", image : UIImage(named:"Kids_welcome")!))
    array.append(KeyValue(key: "livee",value: "Live Entertainment", image : UIImage(named:"Live_Entertainment")!))
    array.append(KeyValue(key: "outc",value: "Outdoor Cooling", image : UIImage(named:"outdoor_cooling")!))
    array.append(KeyValue(key: "outh",value: "Outdoor Heating", image : UIImage(named:"outdoor_Heating")!))
    array.append(KeyValue(key: "outs",value: "Outdoor Sitting", image : UIImage(named:"outdoor_seating")!))
    array.append(KeyValue(key: "parking",value: "Parking", image : UIImage(named:"Parking")!))
    array.append(KeyValue(key: "pet",value: "Pets Allowed", image : UIImage(named:"Pets_Allowed")!))
    array.append(KeyValue(key: "smokein",value: "Smoking Indoor", image : UIImage(named:"Smoking_outdoor")!))
    array.append(KeyValue(key: "smokeout",value: "Smoking Outdoor", image : UIImage(named:"Smoking_outdoor")!))
    array.append(KeyValue(key: "smokesh",value: "Smoking Shisha", image : UIImage(named:"Smoking_Shisha")!))
    array.append(KeyValue(key: "sports",value: "Sports Screens", image : UIImage(named:"Sports_Screens")!))
    array.append(KeyValue(key: "playarea",value: "Supervised Play Area", image : UIImage(named:"Supervised_Play_Area")!))
    array.append(KeyValue(key: "takeaway",value: "Takeaway", image : UIImage(named:"Takeaway")!))
    array.append(KeyValue(key: "valet",value: "Valet Parking", image : UIImage(named:"Valet_parking")!))
    array.append(KeyValue(key: "wheelch",value: "Wheelchair Accessible", image : UIImage(named:"wheelchair_accessible")!))
    array.append(KeyValue(key: "wifi",value: "Wi-Fi", image : UIImage(named:"Wi_Fi")!))*/
    
    return array
  }
  static func salonAndSpaArray() -> Array<KeyValue> {
    var array : Array<KeyValue> = Array<KeyValue>()
    
    array.append(KeyValue(key: "byappon",value: "By Appointment only",image: UIImage()))
    array.append(KeyValue(key: "cofrie",value: "Couple Friendly",image: UIImage()))
    array.append(KeyValue(key: "faciin",value: "Indoor Facilities",image: UIImage()))
    array.append(KeyValue(key: "faciout",value: "Outdoor Facilities",image: UIImage()))
    array.append(KeyValue(key: "refresh",value: "Refreshments",image: UIImage()))
    array.append(KeyValue(key: "certi",value: "Certified",image: UIImage()))
    array.append(KeyValue(key: "feonly",value: "Female only",image: UIImage()))
    array.append(KeyValue(key: "playarea",value: "Supervised Play Area",image : UIImage(named:"Supervised_Play_Area")!))
    array.append(KeyValue(key: "parking",value: "Parking", image : UIImage(named:"Parking")!))
    array.append(KeyValue(key: "valet",value: "Valet Parking", image : UIImage(named:"Valet_parking")!))
    array.append(KeyValue(key: "maonly",value: "Male only",image: UIImage()))
    
    return array
  }
  
  
  
  static func attractionAndleisure() -> Array<KeyValue> {
    var array : Array<KeyValue> = Array<KeyValue>()
    
    array.append(KeyValue(key: "agerest",value: "Age Restriction",image: UIImage()))
    array.append(KeyValue(key: "avia",value: "Aviation",image: UIImage()))
    array.append(KeyValue(key: "boating",value: "Boating",image: UIImage()))
    array.append(KeyValue(key: "dessafari",value: "Desert Safari",image: UIImage()))
    array.append(KeyValue(key: "extremes",value: "Extreme Sports",image: UIImage()))
    array.append(KeyValue(key: "fishing",value: "Fishing",image: UIImage()))
    array.append(KeyValue(key: "golf",value: "Golf",image: UIImage()))
    array.append(KeyValue(key: "heighrest",value: "Height Restriction",image: UIImage()))
    array.append(KeyValue(key: "holiprog",value: "Holiday Programmes",image: UIImage()))
    array.append(KeyValue(key: "actin",value: "Indoor Activities",image: UIImage()))
    array.append(KeyValue(key: "playin",value: "Indoor Play Area",image: UIImage()))
    array.append(KeyValue(key: "kids",value: "Kids Welcome",image: UIImage(named:"Kids_welcome")!))
    array.append(KeyValue(key: "livee",value: "Live Entertainment", image : UIImage(named:"Live_Entertainment")!))
    array.append(KeyValue(key: "motors",value: "Motor Sports",image:UIImage()))
    array.append(KeyValue(key: "actout",value: "Outdoor Activities",image:UIImage()))
    array.append(KeyValue(key: "outc",value: "Outdoor Cooling", image : UIImage(named:"outdoor_cooling")!))
    array.append(KeyValue(key: "playout",value: "Outdoor Play Area",image:UIImage()))
    array.append(KeyValue(key: "parking",value: "Parking", image : UIImage(named:"Parking")!))
    array.append(KeyValue(key: "racqs",value: "Racquet Sports",image:UIImage()))
    array.append(KeyValue(key: "teams",value: "Team Sports",image:UIImage()))
    array.append(KeyValue(key: "themep",value: "Theme Park",image:UIImage()))
    array.append(KeyValue(key: "waterp",value: "Water Park",image:UIImage()))
    array.append(KeyValue(key: "waters",value: "Water Sports",image:UIImage()))
    
    return array
  }
  
  static func retailAndservinces() -> Array<KeyValue> {
    var array : Array<KeyValue> = Array<KeyValue>()
    
    array.append(KeyValue(key: "byappon",value: "By Appointment Only",image: UIImage()))
    array.append(KeyValue(key: "delivery",value: "Delivery",image: UIImage()))
    array.append(KeyValue(key: "pickdrop",value: "Pick up/Drop off",image: UIImage()))
    
    
    
    
    return array
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}

class KeyValue {
  var key : String! = ""
  var value : String! = ""
  var image : UIImage! = UIImage()
  
  init(key : String, value: String, image : UIImage) {
    self.key = key
    self.value = value
    self.image = image
  }
  
}
