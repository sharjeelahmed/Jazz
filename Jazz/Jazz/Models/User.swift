//
//  User.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/19/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

class User: NSObject{
  
  static func setProfileImage(image:String){
    let defaults = UserDefaults.standard
    defaults.setValue(image, forKey: "image")
    defaults.synchronize()
  }
  static func getProfileImage()->String{
    let defaults = UserDefaults.standard
    guard let city = defaults.string(forKey: "image") else { return "" }
    return city
  }
  
  
  static func setCity(city:String){
    let defaults = UserDefaults.standard
    defaults.setValue(city, forKey: "city")
    defaults.synchronize()
  }
  static func getCity()->String{
    let defaults = UserDefaults.standard
    guard let city = defaults.string(forKey: "city") else { return "" }
	return city.localizedLowercase
  }
  
  static func setPinCode(pin_code:String){
   // let defaults = UserDefaults.standard
	UserDefaults.standard.set(pin_code, forKey: "pin_code")
	let name = UserDefaults.standard.string(forKey: "pin_code")
	print(name)


	//defaults.set(pin_code, forKey: "pin_code")
    //defaults.setValue(pin_code, forKey: "pin_code")
   // defaults.synchronize()
  }
  static func getPinCode()->String{
    //let defaults = UserDefaults.standard
    guard let pinCode = UserDefaults.standard.string(forKey: "pin_code") else { return "" }
	let name = UserDefaults.standard.string(forKey: "pin_code")
	print(name)
    return pinCode
  }
  static func setUserEmail(email:String){
    let defaults = UserDefaults.standard
    defaults.setValue(email, forKey: "user_email")
    defaults.synchronize()
  }
  static func getUserEmail()->String{
    let defaults = UserDefaults.standard
    guard let email = defaults.string(forKey: "user_email") else { return "" }
    return email
  }
  static func setFirstName(userName:String){
    let defaults = UserDefaults.standard
    defaults.setValue(userName, forKey: "fname")
    defaults.synchronize()
  }
  static func getFirstName()->String{
    let defaults = UserDefaults.standard
    guard let fname = defaults.string(forKey: "fname") else { return ""}
    return fname
  }
  
  static func setLastName(userName:String){
    let defaults = UserDefaults.standard
    defaults.setValue(userName, forKey: "lname")
    defaults.synchronize()
  }
  static func getLastName()->String{
    let defaults = UserDefaults.standard
    guard let lname = defaults.string(forKey: "lname") else { return ""}
    return lname
  }
  
  static func setGender(userName:String){
    let defaults = UserDefaults.standard
    defaults.setValue(userName, forKey: "gender")
    defaults.synchronize()
  }
  static func getGender()->String{
    let defaults = UserDefaults.standard
    guard let gender = defaults.string(forKey: "gender") else { return ""}
    return gender
  }
  
  static func setTelephone(userName:String){
    let defaults = UserDefaults.standard
    defaults.setValue(userName, forKey: "phone")
    defaults.synchronize()
  }
  static func getTelephone()->String{
    let defaults = UserDefaults.standard
    guard let telephone = defaults.string(forKey: "phone") else { return ""}
    return telephone
  }
  
  static func setDOB(userName:String){
    let defaults = UserDefaults.standard
    defaults.setValue(userName, forKey: "dob")
    defaults.synchronize()
  }
  static func getDOB()->String{
    let defaults = UserDefaults.standard
    guard let dob = defaults.string(forKey: "dob") else { return "Date Of Birth"}
    return dob
  }
  
  
  static func setCurrency(userName:String){
    let defaults = UserDefaults.standard
    defaults.setValue(userName, forKey: "currency")
    defaults.synchronize()
  }
  static func getCurrency()->String{
    let defaults = UserDefaults.standard
    guard let currency = defaults.string(forKey: "currency") else { return "PKR"}
    return currency
  }
  
  
  static func setMembershipDate(userName:String){
    let defaults = UserDefaults.standard
    defaults.setValue(userName, forKey: "membershipdate")
    defaults.synchronize()
  }
  static func getMembershipDate()->String{
    let defaults = UserDefaults.standard
    guard let membershipdate = defaults.string(forKey: "membershipdate") else { return ""}
    return membershipdate
  }
  
  static func setUserSessionID(session:String){
    let defaults = UserDefaults.standard
    defaults.setValue(session, forKey: "sessionID")
    defaults.synchronize()
  }
  static func getUserSessionID()->String{
    let defaults = UserDefaults.standard
    guard let sessionID = defaults.string(forKey: "sessionID") else { return "" }
    return sessionID
  }
  static func setUserID(user_ID:String){
    let defaults = UserDefaults.standard
    defaults.setValue(user_ID, forKey: "user_ID")
    defaults.synchronize()
  }
  
  
  static func getUserID() -> String{
    let defaults = UserDefaults.standard
    guard let userID = defaults.string(forKey: "user_ID") else { return "1" }
    return userID
  }
  
  static func setSelectedBtn(tag:Int){
    let defaults = UserDefaults.standard;
    defaults.set(tag, forKey: "btnSelected");
    defaults.synchronize()
  }
  static func getSelectedBtn()->Int{
    let defaults = UserDefaults.standard;
    return defaults.integer(forKey:"btnSelected")
    
  }
  
  static func setCityName(city:String){
    let defaults = UserDefaults.standard;
    defaults.setValue(city, forKey: "city");
    defaults.synchronize()
  }
  static func getCityName()->String{
    let defaults = UserDefaults.standard;
    guard let userID = defaults.string(forKey: "city") else { return "Karachi" }
    
    
    print(userID)
    return userID;
  }
  
  
  static func setViewName(viewName:String){
    let defaults = UserDefaults.standard;
    defaults.setValue(viewName, forKey: "viewName");
    defaults.synchronize()
  }
  static func getViewName()->String{
    let defaults = UserDefaults.standard;
    guard let userID = defaults.string(forKey: "viewName") else { return "List" }
    
    
    return userID;
  }
  
  
  static func isValidEmailAddress(emailAddressString: String) -> Bool {
    
    var returnValue = true
    let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    
    do {
      let regex = try NSRegularExpression(pattern: emailRegEx)
      let nsString = emailAddressString as NSString
      let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
      
      if results.count == 0
      {
        returnValue = false
      }
      
    } catch let error as NSError {
      print("invalid regex: \(error.localizedDescription)")
      returnValue = false
    }
    
    return  returnValue
  }
  
}

