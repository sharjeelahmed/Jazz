//
//  StorageService.swift
//  Vouch365
//
//  Created by Veer Suthar on 2/20/18.
//  Copyright © 2018 Veer Suthar. All rights reserved.
//

import Foundation
import Foundation
import RealmSwift

class StorageService {
    
    var store: Realm {
        get {
            let realm = try! Realm()
            return realm
        }
    }
    
    class func saveUser(realmObject:VouchUser){
        let realm = try! Realm()
        let results = realm.objects(VouchUser.self)
        for value in results {
            try! realm.write {
                realm.delete(value)
            }
        }
        
        try! realm.write {
            realm.add(realmObject)
        }
    }
    
    class func getUser() -> VouchUser {
        let realm = try! Realm()
        let results = realm.objects(VouchUser.self)
        var user = VouchUser()
        
        if results.count > 0 {
            user =  results[0]
        }
        
        return user
    }
    
    class func deleteUser() {
        let realm = try! Realm()
        let results = realm.objects(VouchUser.self)
        try! realm.write {
            realm.delete(results)
        }
    }
    
    class func saveCity(realmObject:VouchCity){
        let realm = try! Realm()
        try! realm.write {
			realm.add(realmObject, update: .all)
            //realm.add(realmObject, update: true)
        }
    }
    
    class func getCitiies() -> Results<VouchCity> {
        let realm = try! Realm()
        let results = realm.objects(VouchCity.self)
        return results
    }
}

