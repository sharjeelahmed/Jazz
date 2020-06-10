//
//  ServiceWrapper.swift
//  Voucher365
//
//  Created by Veer Suthar on 3/14/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class ServiceWrapper: ServiceLayer {
  
  /*   Post comments */
  class func addAFriend(requestObject: NSDictionary,
                    completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    // Call the function to Hit the POST request
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiAddFriend as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      //activity.stopAnimating()
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      print("Response:",response)
      
      completionHandler(success, response)
    }
  }
  
  /*   Post comments */
  class func signUp(requestObject: NSDictionary,
                    completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    // Call the function to Hit the POST request
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.registerURLApi as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      //activity.stopAnimating()
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      print("Response:",response)
      
      completionHandler(success, response)
      
    }    
  }
  
  /*   Post comments */
  class func reimburseVoucher(requestObject: NSDictionary,
                              completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    // Call the function to Hit the POST request
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiReimburseVoucher as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      //activity.stopAnimating()
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
  }
  
  /*   Post comments */
  class func reimbadd(requestObject: NSDictionary,
                    completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    // Call the function to Hit the POST request
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiReimburse as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      //activity.stopAnimating()
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
  }
  
  /*   Post comments */
  class func purchasePing(requestObject: NSDictionary,
                      completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    // Call the function to Hit the POST request
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiPurchasePing as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      //activity.stopAnimating()
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
  }
  
  /*   Post comments */
  class func vouchPingCall(requestObject: NSDictionary,
                      completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    // Call the function to Hit the POST request
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiVouchPingCall as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      //activity.stopAnimating()
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      print("Response:",response)

      completionHandler(success, response)
      
    }
  }
    
    class func vouchPingCallList(requestObject: NSDictionary,
                             completionHandler:
        @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
        // Call the function to Hit the POST request
        //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
        let Apiname = Constants.ApiVouchPingListCall + String( User.getUserID())

        ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Apiname) as String){  (success, response)-> Void in
            //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            
            //activity.stopAnimating()
            print("Url ")
            print("Request Parameters:", requestObject)
            print("success :",success )
            print("Response:",response)
            
            completionHandler(success, response)
            
        }
    }
  
  
  class func signIn(requestObject: NSDictionary,
                    completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    // Call the function to Hit the POST request
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.signInUrlApi as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
    
    
  }
  class func forgetPassword(requestObject: NSDictionary,
                            completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    // Call the function to Hit the POST request
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.forgetPasswordApi as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
    
    
  }
  
  class func loginWithSocial(requestObject: NSDictionary,
                             completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    
    // Call the function to Hit the POST request
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiSocialLogin as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
    
    
  }
  class func logOut(requestObject: NSDictionary,
                    completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiLogout as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
  }
  class func sessionValidate(requestObject: NSDictionary,
                            completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    
    // Call the function to Hit the POST request
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiIsSessionValidate as NSString) as String){  (success, response)-> Void in
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
    }
  }
  
  
  class func purchaseVoucherReimbursement(requestObject: NSDictionary,
                    completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    // Call the function to Hit the POST request
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.registerURLApi as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      //activity.stopAnimating()
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
  }
  
  
  class func getSliderData(requestObject: NSDictionary, type: String,
                           completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    
    // Call the function to Hit the POST request
   // let user = User.getUserID()
	let user = "03124578451"
    let city = User.getCity()
	
	
    
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    //activity.center = CGPoint(x: (appDelegate.window?.frame.origin.x)!/2, y: (appDelegate.window?.frame.origin.y)!/2)
    // appDelegate.window?.addSubview(activity)
    // Call the function to Hit the POST request
    //activity.startAnimating()
    
    
    let ApiSlider = Constants.baseUrlStagging + "/slider/getSlidesJson/\(user)/\(city)"
    
    ServiceLayer.getDataWithObject(parameters: requestObject, apiName: ApiSlider as String) {
      (success, response, error) -> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      if success {
        print(response)
        //print(response)
        completionHandler(success, response)
        
      }
    }
    
  }
	
	class func getPopUpData(requestObject: NSDictionary,
							completionHandler:
		@escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
		
		// Call the function to Hit the POST request
		let user = User.getUserID()
		let city = User.getCity()
		
		let ApiSlider = Constants.baseUrlStagging + "/popnotiLE.php"
		print(ApiSlider)
		
		
		
		let  parameters:[String:Any] = ["user_ID": user,
										"city":city.lowercased(),
		]
		ServiceLayer.postDataWithObject(parameter: parameters as NSDictionary, apiName:(ApiSlider)){  (success, response)-> Void in
			
			if success {
				print(response)
				//print(response)
				completionHandler(success, response)
				
			}else{
				completionHandler(success, response)
				
			}
		}
		
	}
  
  class func offerPages(requestObject: NSDictionary, type: String,
                        completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    
    // Call the function to Hit the POST request
    // adding Header
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    let ApiPremiumPage = Constants.baseUrlStagging + "/api/sp/ot/" + type + "/10"
    
    ServiceLayer.getDataWithObject(parameters: requestObject, apiName: ApiPremiumPage as String) {
      (success, response, error) -> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      if success {
        // print(response)
        //print(response)
        completionHandler(success, response)
        
      }
    }
    
  }
  class func getVoucherSPUserId(requestObject: NSDictionary,
                                completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    // Call the function to Hit the POST request
    let ApiFavGetWithUserID =  Constants.baseUrlStagging + "/api/vc/sp/66/userID/11030"
    
    ServiceLayer.getDataWithObject(parameters: requestObject, apiName:ApiFavGetWithUserID as String) {
      (success, response, error) -> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      if success {
        // print(response)
        //print(response)
        
        completionHandler(success, response)
        
      }
    }
    
    
  }
  class func getVcSpWithUserId(requestObject: NSDictionary,
                               completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    // Call the function to Hit the POST request
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiVcSpWithUserId as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
    
    
  }
  
  class func getRedeem(requestObject: NSDictionary,
                       completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    
    // Call the function to Hit the POST request
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiRedeem as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      print("Response:",response)

      completionHandler(success, response)
      
    }
  }
  
  //  class func getRedeemView(requestObject: NSDictionary,
  //                           completionHandler:
  //    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
  //
  //
  //    // Call the function to Hit the POST request
  //
  //    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiRedeemView as NSString) as String){  (success, response)-> Void in
  //
  //      print("Url ")
  //      print("Request Parameters:", requestObject)
  //      print("success :",success )
  //      completionHandler(success, response)
  //      print("Response:",response)
  //
  //    }
  //
  //
  //  }
  
  
  class func userFavAdd(requestObject: NSDictionary,
                        completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    // Call the function to Hit the POST request
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiUserFavAdd as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
    
    
  }
  class func userFavRemove(requestObject: NSDictionary,
                           completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    // Call the function to Hit the POST request
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiUserFavRemove as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
    
    
  }
  
  //  class func postUserFavRemoveView(requestObject: NSDictionary,
  //                                   completionHandler:
  //    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
  //
  //
  //    // Call the function to Hit the POST request
  //
  //    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiUserFavRemoveView as NSString) as String){  (success, response)-> Void in
  //
  //      print("Url ")
  //      print("Request Parameters:", requestObject)
  //      print("success :",success )
  //      completionHandler(success, response)
  //      print("Response:",response)
  //
  //    }
  //
  //
  //  }
  //
  
  
  
  class func friendListCall(user_id : String,
                          completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void){
    
    let ApiGetCompanyDetail =  Constants.baseUrlStagging + "/user/fr_getlist/\(user_id)"
    
    ServiceLayer.getDataWithObject(parameters: ["":""], apiName:ApiGetCompanyDetail as String) {
      (success, response, error) -> Void in
      if success {
        completionHandler(success, response)
      }
    }
  }
  
  class func getUserFav(user_id : String,
                        completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void){
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    let ApiGetCompanyDetail =  Constants.baseUrlStagging + "/api/sp/ot/favourites/userID/\(user_id)"
    
    ServiceLayer.getDataWithObject(parameters: ["":""], apiName:ApiGetCompanyDetail as String) {
      (success, response, error) -> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      if success {
        completionHandler(success, response)
        
      }
    }
  }
  
  class func userPremiumRegister(requestObject: NSDictionary,
                                 completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    
    
    // Call the function to Hit the POST request
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiUserPrRegister as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
  }
  
  class func postUserUpdate(requestObject: NSDictionary,
                            completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    // Call the function to Hit the POST request
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiUserUpdate as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
    
    
  }

  //ApiUserDeleteAllSession
  class func userDeleteAllSession(requestObject: NSDictionary,
                                  completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    // Call the function to Hit the POST request
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiUserDeleteAllSession as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
    
    
  }
  class func redemptionHistory(requestObject: NSDictionary,
                               completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiRedemptionHistory as NSString) as String){  (success, response)-> Void in
      completionHandler(success, response)
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
    }
  }
  
  //ApiTotalSaving
  
  class func userTotalSavings(requestObject: NSDictionary,
                              completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    
    // Call the function to Hit the POST request
    
    ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiTotalSaving as NSString) as String){  (success, response)-> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      print("Url ")
      print("Request Parameters:", requestObject)
      print("success :",success )
      completionHandler(success, response)
      print("Response:",response)
      
    }
  }
  
  class func getHomeService(cat : String, cat2 : String,
                            completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    let city_param = User.getCity()
    
    //let ApiFavGetWithUserID =  Constants.baseUrlStagging + "/api/sp/ot/\(cat)/city/\(city_param)/cat/\(cat2)"
	  let ApiFavGetWithUserID =  Constants.baseUrlStagging + "/api/sp/ot/\(cat)/city/\(city_param)/cat/kids"
    
    ServiceLayer.getDataWithObject(parameters: ["":""], apiName:ApiFavGetWithUserID as String) {
      (success, response, error) -> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      if success {
        print(response)
        completionHandler(success, response)
        
      }
    }
  }
  
  
  class func getCompanyDetail(sp_id : String, user_id : String,
                              completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    
    // Call the function to Hit the POST request
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    let ApiGetCompanyDetail =  Constants.baseUrlStagging + "/company/details/\(sp_id)/\(user_id)"
    
    ServiceLayer.getDataWithObject(parameters: ["":""], apiName:ApiGetCompanyDetail as String) {
      (success, response, error) -> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      if success {
        print(response)
        completionHandler(success, response)
        
      }
    }
  }
  
  class func getNotification(userId:String , city:String,completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void){
    let ApigetNotificaion =  Constants.baseUrlStagging + "/noti/getNotifications/\(userId)/\(city)"
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    let param = ["user_Id":userId,"city":city]
    ServiceLayer.getDataWithObject(parameters: param as NSDictionary, apiName:ApigetNotificaion as String) {
      (success, response, error) -> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      if success {
        print(response)
        completionHandler(success, response)
        
      }
    }
    
  }
  
  class func searchCall(search_text:String,completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void){
    
    //NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData())
    
    let city_param = User.getCity()

    let ApigetSearch =  Constants.baseUrlStagging + "/company/simplesearch/\(city_param)/\(search_text)"
    
    ServiceLayer.getDataWithObject(parameters: ["":""], apiName:ApigetSearch as String) {
      (success, response, error) -> Void in
      //NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
      
      if success {
        
        print(response)
        completionHandler(success, response)
        
      }
    }
    
  }
  
  
  class func getProfile(user_id : String,
                        completionHandler:
    @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
    
    // Call the function to Hit the POST request
    let ApiGetCompanyDetail =  Constants.baseUrlStagging + "/user/bd_getlist/\(user_id)"
    
    ServiceLayer.getDataWithObject(parameters: ["":""], apiName:ApiGetCompanyDetail as String) {
      (success, response, error) -> Void in
      if success {
        print(response)
        completionHandler(success, response)
      }
    }
  }
    
    
    class func getCities(completionHandler:
        @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
        
        // Call the function to Hit the POST request
        let ApiCityList =  Constants.ApiCityList
        
        ServiceLayer.getDataWithObject(parameters: ["":""], apiName:ApiCityList as String) {
            (success, response, error) -> Void in
            if success {
                print(response)
                completionHandler(success, response)
                
            }
        }
    }
	
	 class func jazzSdkCall(requestObject: NSDictionary,
					   completionHandler:
	   @escaping (_ success : Bool, _ response : NSDictionary) -> Void) {
	   // Call the function to Hit the POST request
	   ServiceLayer.postDataWithObject(parameter: requestObject, apiName:(Constants.ApiVouchPsoSdk as NSString) as String){  (success, response)-> Void in
		 completionHandler(success, response)
	   }
	 }
}
