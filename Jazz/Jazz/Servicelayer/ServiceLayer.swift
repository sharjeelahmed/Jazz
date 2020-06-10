//
//  ServiceLayer.swift
//  Voucher365
//
//  Created by Veer Suthar on 3/14/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation
import Alamofire

class ServiceLayer {
  
  /**
   ** POST Method for calling API
   *  Services gateway
   *  Method  get response from server
   *  @parameter              -> requestObject: request josn object ,apiName: api endpoint
   *  @returm                 -> void
   *  @compilationHandler     -> success: status of api, response: respose from server, error: error handling
   **/
  static func postDataWithObject(parameter: NSDictionary, apiName : String,
                                 completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    
    let headers = [
      "Content-Type": "application/x-www-form-urlencoded"
    ]
    
    Alamofire.request(apiName, method: .post, parameters: parameter as? Dictionary, headers: headers).responseJSON {(response:DataResponse<Any>) in
      
      Utilities.removeLoader()
      
      if let JSON = response.result.value as? NSDictionary{
        print("JSON: \(JSON)")
        
        if let status = JSON.object(forKey: "status") as? String{
          if  status == "successful"{
            completionHandler(true, JSON)
          }else{
            completionHandler(false, JSON)
          }
        }else if let error = JSON.object(forKey: "error") as? String{
          print("Error Response \(error)")
          completionHandler(false, JSON)
        }else{
          completionHandler(true, JSON)
        }
      }
      
      if let array_JSON = response.result.value as? NSArray{
        let dict_JSON: [String: NSArray] = ["data": array_JSON]
        print("JSON: \(dict_JSON)")
        completionHandler(true, dict_JSON as NSDictionary)
      }
    }
  }
  
  
  
  static func getDataWithObject( parameters: NSDictionary, apiName : String,
                                 completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary, _ error : Error?) -> Void) {
    
    let headers = [
      "Content-Type": "application/x-www-form-urlencoded"
    ]
    
    print("API \n\(String(describing: apiName))\n\n")
    print("Params \n\(String(describing: parameters))\n\n")
    
    Alamofire.request(apiName, method: .get, parameters: parameters as? Parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
      
      
      print(response.result)
      switch(response.result) {
      case .success(_):
        if response.result.value != nil{
          
          /*
           let array =  response.result.value as! NSArray
           print(array)
           
           completionHandler(true,array,nil)
           */
          
          Utilities.removeLoader()
          
          if let dict_JSON = response.result.value as? NSDictionary{
            print("JSON: \(dict_JSON)")
            completionHandler(true, dict_JSON,nil)
          }
          
          if let array_JSON = response.result.value as? NSArray{
            //            let dict_JSON: Dictionary = Dictionary()
            let dict_JSON: [String: NSArray] = ["data": array_JSON]
            print("JSON: \(dict_JSON)")
            
            completionHandler(true, dict_JSON as NSDictionary,nil)
          }
        }
        
        break
        
      case .failure(let error):
        
        Utilities.removeLoader()
        
        print("Request failed with error: \(response.result.error!)")
        // print((response.result.error! as NSError).localizedDescription)
        
        if error._code == NSURLErrorTimedOut {
          print("message: Request Time Out")
        }
        if response.result.value == nil{
          completionHandler(false, NSDictionary(), response.result.error!)
          break
        }
        completionHandler(false, response.result.value as! NSDictionary, response.result.error!)
        break
        
      }
      
    }
  }
}

