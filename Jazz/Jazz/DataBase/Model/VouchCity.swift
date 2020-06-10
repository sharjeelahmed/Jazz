//
//  VouchCity.swift
//  Vouch365
//
//  Created by Veer Suthar on 2/19/18.
//  Copyright © 2018 Veer Suthar. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class VouchCity: Object, Mappable {
    
    @objc dynamic var city_ID : String = ""
    @objc dynamic var icon : String = ""
    @objc dynamic var name : String = ""
    
    override class func primaryKey() -> String? { return "city_ID" }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        city_ID   <- map["city_ID"]
        icon   <- map["icon"]
        name   <- map["name"]
    }
}

