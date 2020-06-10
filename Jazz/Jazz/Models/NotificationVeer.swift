//
//  Notification.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/25/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

struct NotificationVeer {
    
    var id: String?
    var name: String?
    var desc: String?
    var logo:String?
    var header: String?
    var khi: String?
    var lhr: String?
    var linktype: String?
    var url: String?
    var tab:String?
    var cat:String?
    var spid: String?
    var status: String?
   
    static func getArrayOfNotification(array: Array<Dictionary<String, Any>>) -> Array<NotificationVeer>{
        var list: Array<NotificationVeer> = []
        var notification: NotificationVeer = NotificationVeer()
        for json in array {
            notification.id  =  (json["id"] as? String) ?? ""
            notification.name = (json["name"] as? String) ?? ""
            notification.desc = (json["desc"] as? String) ?? ""
            notification.logo = (json["logo"] as? String) ?? ""
            notification.header = (json["header"] as? String) ?? ""
            notification.khi = (json["khi"] as? String) ?? ""
            notification.lhr = (json["lhr"] as? String) ?? ""
            notification.linktype = (json["linktype"] as? String) ?? ""
            notification.url = (json["url"] as? String) ?? ""
            notification.tab = (json["tab"] as? String) ?? ""
            notification.cat = (json["cat"] as? String) ?? ""
            notification.spid = (json["spid"] as? String) ?? ""
            notification.status = (json["status"] as? String) ?? ""
            list.append(notification)
        }
        return list
    }
}

