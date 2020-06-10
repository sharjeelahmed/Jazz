//
//  VouchManager.swift
//  ActionSheetPicker-3.0
//
//  Created by Shairjeel Ahmed on 23/01/2020.
//

import Foundation
import GooglePlaces
import GoogleMaps


public class VouchManager {
	public init() {}
	
	/*public func GetVouchNavigationController() -> UINavigationController {
		let Vc = UIStoryboard(name: "Main-Pso", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
		Vc.modalPresentationStyle = .fullScreen
		return UINavigationController(rootViewController: Vc)
	}*/
	
	public  func getVouchNavigaionController(unique_param: String,token:String,
									completionHandler:
		@escaping (_ success : Bool, _ navigationController : UINavigationController? , _ errorDes:NSDictionary?) -> Void) {
		
		let requestObject: NSDictionary = ["unique_param":unique_param,"token":token]
		ServiceWrapper.jazzSdkCall(requestObject: requestObject) {
			(success, response) in
			if success == true{
				self.InitializeImpContent()
				User.setUserID(user_ID:unique_param)
				let Vc = UIStoryboard(name: "Main-Pso", bundle: nil).instantiateViewController(withIdentifier: "RootListMapViewController") as! RootListMapViewController
				Vc.titleOfController = "Food & Drinks"
				Vc.argumentToServer = "restaurant"
				Vc.hidesBottomBarWhenPushed = true
				Vc.modalPresentationStyle = .fullScreen
				let navVc =  UINavigationController(rootViewController: Vc)
				completionHandler(true,navVc,nil)
			}else{
				completionHandler(false,nil,response)
			}
		}
	}
	
	 func InitializeImpContent(){
		GMSServices.provideAPIKey("AIzaSyB4ocLpkc5F2-3G4bts4nZg9m2WQKiOOLY")
		GMSPlacesClient.provideAPIKey("AIzaSyB4ocLpkc5F2-3G4bts4nZg9m2WQKiOOLY")
		let city = User.getCity()
		if city.count == 0 {
			User.setCityName(city: "karachi")
		}
		User.setViewName(viewName: "List")
	}
}





