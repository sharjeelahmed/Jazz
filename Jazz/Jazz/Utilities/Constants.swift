//
//  Constants.swift
//  Voucher365
//
//  Created by Veer Suthar on 3/15/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation

class Constants: NSObject {
  
  override init() {
    super.init()
  }
  
    
    
	static let baseUrlStagging = "https://secapijazz.vouch365.mobi"
	static let baseUrl = "https://secapipso.vouch365.mobi"
	

    
    
  
  static let registerURLApi =  baseUrlStagging + "/user/au_signup"
  static let signInUrlApi =   baseUrlStagging + "/user/au_login"
  static let forgetPasswordApi =   baseUrlStagging + "/user/au_forget_pass"
  static let ApiSocialLogin = baseUrlStagging + "/user/au_login_social"
  static let ApiLogout = baseUrlStagging + "/user/au_logout"
  static let ApiIsSessionValidate = baseUrlStagging + "/user/au_verify_session"
  static let ApiPremiumPage = baseUrlStagging + "/api/sp/ot/premium/10" // done
  static let ApiFavGetWithUserID = baseUrlStagging + "/user/fv_get/sp_ID/10/user_ID/20" // done
  static let ApiVcSpWithUserId = baseUrlStagging + "/api/vc/sp/66/userID/20" // Done
  static let ApiRedeem = baseUrlStagging + "//redeem/rd_redeem"
  static let ApiUserFavAdd = baseUrlStagging + "/user/fv_add"
  static let ApiUserFavRemove = baseUrlStagging + "/user/fv_remove"
  static let ApiUserFavGet = baseUrlStagging + "/api/sp/ot/favourites/userID/"
  static let ApiUserPrRegister = baseUrlStagging + "/user/pr_register"
  static let ApiUserUpdate = baseUrlStagging + "/user/au_update"
  static let ApiUserDeleteAllSession = baseUrlStagging + "/user/au_del_allsessions"
  static let ApiRedemptionHistory = baseUrlStagging + "/user/rd_redemption_history"
  static let ApiTotalSaving = baseUrlStagging + "/user/rd_total_savings"
  static let ApiAvatarUpload = baseUrlStagging + "/user/au_upAvatar"
  static let ApiReimburse =  baseUrlStagging + "/user/au_reimbadd"
  static let ApiReimburseVoucher =  baseUrlStagging + "/user/au_reimbvoucher"
  static let ApiPurchasePing =  baseUrlStagging + "/user/au_pingadd"
  static let ApiVouchPingCall =  baseUrlStagging + "/user/au_pingvoucher"
  static let ApiAddFriend =  baseUrlStagging + "/user/fr_add"
  static let ApiCityList =  baseUrlStagging + "/city/get_cities/"
    //sharjeel
    static let ApiVouchPingListCall =  baseUrlStagging + "/user/pn_getlist/"
    static let ApiVouchPsoSdk =  baseUrlStagging + "/user/js_sdk_login"

	 


}
