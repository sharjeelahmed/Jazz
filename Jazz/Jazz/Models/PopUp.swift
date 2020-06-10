//
//  PopUp.swift
//  Vouch365
//
//  Created by Shairjeel Ahmed on 20/10/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import Foundation

struct PopUP {
	
	var id: String?
	var image : String?
	var cityname:String?
	var linktype: String?
	var url: String?
	var tab: String?
	var cat : String?
	var spid: String?
	var status: String?
	
	
	mutating func setDataFromServer(dict: NSDictionary){
		id = dict.value(forKey: "id") as? String
		image = dict.value(forKey: "image") as? String
		cityname = dict.value(forKey: "cityname") as? String
		linktype = dict.value(forKey: "linktype") as? String
		url = dict.value(forKey: "url") as? String
		tab = dict.value(forKey: "tab") as? String
		cat = dict.value(forKey: "cat") as? String
		spid = dict.value(forKey: "spid") as? String
		status = dict.value(forKey: "status") as? String
		
	}
}


