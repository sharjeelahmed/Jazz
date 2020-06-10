//
//  VouchUser.swift
//  Vouch365
//
//  Created by Veer Suthar on 2/19/18.
//  Copyright © 2018 Veer Suthar. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift
import ObjectMapper_Realm

class VouchUser: Object, Mappable {
    
    @objc dynamic var ID : String = ""

    @objc dynamic var image : String = ""
    @objc dynamic var city : String = ""
    @objc dynamic var pin_code : String = ""
    @objc dynamic var user_email : String = ""
    
    @objc dynamic var fname : String = ""
    @objc dynamic var lname : String = ""
    @objc dynamic var gender : String = ""
    @objc dynamic var phone : String = ""
    @objc dynamic var dob : String = ""
    
    @objc dynamic var currency : String = ""
    @objc dynamic var membershipdate : String = ""
    @objc dynamic var user_ID : String = ""
    @objc dynamic var btnSelected : String = ""
    
    @objc dynamic var sessionID : String = ""

    @objc dynamic var viewName : String = ""
    
    override class func primaryKey() -> String? { return "ID" }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        image   <- map["image"]
        city   <- map["city"]
        pin_code   <- map["pin_code"]
        user_email   <- map["user_email"]
        fname   <- map["fname"]
        lname   <- map["lname"]
        gender   <- map["gender"]
        dob   <- map["dob"]
        currency   <- map["currency"]
        membershipdate   <- map["membershipdate"]
        sessionID   <- map["sessionID"]
        user_ID   <- map["user_ID"]
        viewName   <- map["viewName"]
        
    }
}
