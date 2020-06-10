//
//  CompanyDetail.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/5/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

struct CompanyDetail {
    
    var name:String?
    var logo: String?
    var locality: String?
    var category: String?
    var city: String?
    var latitude: String?
    var longitude: String?
    var state: String?
    var desc: String?
    var number: String?
    var header: String?
    var locations: String?
    var Year: String?
    var Caps_City: String?

    var bakery:String?
    var brunch:String?
    var buffet: String?
    var delivery: String?
    var groups: String?
    var halal: String?
    var kids: String?
    var livee: String?
    var outc: String?
    var outh:String?
    var outs: String?
    var parking: String?
    var pet: String?
    var smokein: String?
    var smokeout: String?
    var smokesh: String?
    var sports: String?
    var playarea: String?
    var takeaway: String?
    var valet: String?
    var wheelch: String?
    var wifi: String?
    
    
    var favourite:Bool?
    
    var locationData: NSArray?
    var vouchersData: NSArray?
    
    var array_location: Array <Location> = Array()
    var array_vouchers: Array <VoucherData> = Array()
    
    mutating func setDataFromServer(_ dict: NSDictionary){
        
        //print(dict)
        
        let object = dict.object(forKey: "data") as? NSArray
        let dict = object?.object(at: 0) as! NSDictionary
        
        name = dict.value(forKey: "name") as? String
        logo = dict.value(forKey: "logo") as? String
        locality = dict.value(forKey: "locality") as? String
        category = dict.value(forKey: "category") as? String
        city = dict.value(forKey: "city") as? String
        latitude = dict.value(forKey: "latitude") as? String
        longitude = dict.value(forKey: "longitude") as? String
        state = dict.value(forKey: "state") as? String
        desc = dict.value(forKey: "desc") as? String
        number = dict.value(forKey: "number") as? String
        header = dict.value(forKey: "header") as? String
        locations = dict.value(forKey: "locations") as? String
        Year = dict.value(forKey: "Year") as? String
        Caps_City = dict.value(forKey: "Caps_City") as? String
        
        bakery = dict.value(forKey: "bakery") as? String
        brunch = dict.value(forKey: "brunch") as? String
        buffet = dict.value(forKey: "buffet") as? String
        delivery = dict.value(forKey: "delivery") as? String
        groups = dict.value(forKey: "groups") as? String
        halal = dict.value(forKey: "halal") as? String
        kids = dict.value(forKey: "kids") as? String
        livee = dict.value(forKey: "livee") as? String
        outc = dict.value(forKey: "outc") as? String
        outh = dict.value(forKey: "outh") as? String
        outs = dict.value(forKey: "outs") as? String
        parking = dict.value(forKey: "parking") as? String
        pet = dict.value(forKey: "pet") as? String
        smokein = dict.value(forKey: "smokein") as? String
        smokeout = dict.value(forKey: "smokeout") as? String
        smokesh = dict.value(forKey: "smokesh") as? String
        sports = dict.value(forKey: "sports") as? String
        playarea = dict.value(forKey: "playarea") as? String
        takeaway = dict.value(forKey: "takeaway") as? String
        valet = dict.value(forKey: "valet") as? String
        wheelch = dict.value(forKey: "wheelch") as? String
        wifi = dict.value(forKey: "wifi") as? String
        
        
        favourite = dict.value(forKey: "favourite") as? Bool
        
        locationData = dict.value(forKey: "locationData") as? NSArray
        var location = Location()
        
        if ((locationData?.count)! > 0) {
            for index in 0...(locationData?.count)!-1 {
                location = Location()
                location.setDataFromServer(location: (locationData?.object(at: index) as? NSDictionary)!)
                array_location.append(location)
            }
        }
        
        vouchersData = dict.value(forKey: "vouchersData") as? NSArray
        var voucher = VoucherData()
        
        if ((vouchersData?.count)! > 0) {
            for index in 0...(vouchersData?.count)!-1 {
                voucher = VoucherData()
                voucher.setDataFromServer(location: (vouchersData?.object(at: index) as? NSDictionary)!)
                array_vouchers.append(voucher)
            }
        }
    }
}

