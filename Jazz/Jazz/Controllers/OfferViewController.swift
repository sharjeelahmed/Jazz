//
//  OfferViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/19/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit
import KXHtmlLabel
import GoogleMaps
import GooglePlaces

class OfferViewController: UIViewController ,PINViewDelegate{
  
  var local_profile: UserProfile = UserProfile()
  var array_vouchers : Array <String> = Array()
  
  @IBOutlet weak var button_call: UIButton!
  @IBOutlet weak var button_pings: UIButton!
  @IBOutlet weak var button_dollar: UIButton!
  @IBOutlet weak var button_share: UIButton!
  @IBOutlet weak var label_msg: UILabel!
  @IBOutlet weak var view_msg: UIView!
  
  @IBOutlet weak var button_send_cancel: UIButton!
  
  
  var is_selection_mode_reimburse = false
  var is_selection_mode_pings = false
  
  var friend : Friend = Friend()
  
  var data = [Any]()
  var companyData = [Any]()
  
  var friendSearchXib = FriendSearch()
  var array_friends :Array <Friend> = Array()
  
  var container: UIView = UIView()
  var voucher : VoucherData = VoucherData()
  
  @IBOutlet weak var tableview_offer: UITableView!
  var offerTypeArray = ["new","hot","my","monthly","premium"]
  
  @IBOutlet weak var collectionview_header: UICollectionView!
  @IBOutlet weak var imageview_logo: UIImageView!
  
  var company: CompanyDetail = CompanyDetail()
  var location: Location?
  
  weak var delegate:RootOfferDetailsViewController?
  
  var redeemPinView = RedeemPinView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
	InitializeImpContent()
    // Do any additional setup after loading the view.
    let url = URL(string: "\(company.logo!)")
    imageview_logo.kf.setImage(with: url)
    
    if (company.array_vouchers.count != 0){
        voucher = company.array_vouchers [0]

    }
    
    self.view_msg.isHidden = true
    //getProfile(user_id: User.getUserID())
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
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
  
  
  
  @IBAction func didPressCancel(_ sender: UIButton) {
    
    if sender.currentTitle == "Send" {
      Utilities.showLoader(controller: self)
      ServiceWrapper.friendListCall(user_id: User.getUserID()) {
        (success,response) in
        if success{
          
          if let array = response["data"] as? NSArray {
            self.array_friends.removeAll()
            var friend = Friend()
            if ((array.count) > 0) {
              for index in 0...(array.count)-1 {
                friend = Friend()
                friend.setDataFromServer(dict: (array.object(at: index) as? NSDictionary)!)
                self.array_friends.append(friend)
              }
            }
            self.loadingPingAlert()
          }else {
            
            Utilities.showToast(error: "No Friends Added", controller: self)
          }
        }
        
        print("Final Friend is \(self.array_friends)")
      }
      
    }else if sender.currentTitle == "Cancel" {
      self.view_msg.isHidden = true
      self.is_selection_mode_reimburse = false
    }
  }
  
  func reimbuserVoucher(voucher : VoucherData)  {
    var parameters : NSDictionary!
    
    parameters = ["userID": User.getUserID(),
                  "spID":voucher.sp_ID!,
                  "vcID":voucher.vc_ID!]
    
    ServiceWrapper.reimburseVoucher(requestObject: parameters as NSDictionary) {
      (success, response) in
      print("response = %@", response);
      if success {
        self.view_msg.isHidden = true
        self.is_selection_mode_reimburse = false
        self.getProfile(user_id: User.getUserID())
      }else{
        print("Failed")
      }
    }
  }
  func getProfile(user_id: String) {
    
    Utilities.showLoader(controller: self)
    ServiceWrapper.getProfile(user_id: user_id) {
      (success,response) in
      if success{
        print("Response of server is \(response)")
        self.local_profile.setDataFromServer(response)
        if self.local_profile.rvcnt == 0 {
          self.button_dollar.isHidden = true
        }else {
          self.label_msg.text = "Select a voucher to reimbusre. \(self.local_profile.rvcnt!) left"
          self.button_dollar.isHidden = false
        }
        
        if self.local_profile.pcnt == 0 {
          self.button_pings.isHidden = true
        }else{
          self.button_pings.isHidden = false
        }
      }
    }
  }
	
	func fetchCompanyDetail(sp_id: String, user_id: String) {
		
		ServiceWrapper.getCompanyDetail(sp_id: sp_id, user_id: user_id) {
			(success,response) in
			if success{
				print(response)
				var local_company: CompanyDetail = CompanyDetail()
				local_company.setDataFromServer(response)
				let viewController:RootOfferDetailsViewController = UIStoryboard(name: "Main-Pso", bundle: nil).instantiateViewController(withIdentifier: "RootOfferDetailsViewController") as! RootOfferDetailsViewController
				viewController.company = local_company
				viewController.hidesBottomBarWhenPushed = true
			}
		}
	}
  
  
  @IBAction func showPingsView(_ sender: UIButton) {
    
    self.is_selection_mode_pings = true
    self.view_msg.isHidden = false
    array_vouchers.removeAll()
    button_send_cancel.setTitle("Send", for: .normal)
    self.label_msg.text = "Select vouchers to ping. \(self.local_profile.pcnt!) left"
    self.tableview_offer.reloadData()
  }
  
  func loadingPingAlert(){
    
    if !self.friendSearchXib.isDescendant(of: self.view) {
      let viewError = FriendSearch.instanceFromNib()
      
      let rect = CGRect(x: self.view.center.x-viewError.frame.width/2, y: 0, width: 320, height: viewError.frame.height)
      viewError.frame = rect
      
      viewError.textfield_email.tag = 200
      viewError.textfield_email.addTarget(friendSearchXib, action: #selector(FriendSearch.textFieldDidChange(_:)), for: .editingChanged)
      viewError.textfield_email.delegate = self
      
      viewError.textfield_friendName.tag = 300
      viewError.textfield_friendName.addTarget(friendSearchXib, action: #selector(FriendSearch.textFieldDidChange(_:)), for: .editingChanged)
      viewError.textfield_friendName.delegate = self
      
      viewError.my_delegate = self
      
      viewError.table_findFriend.isHidden = true
      viewError.array_friends = self.array_friends
      
      let container: UIView = UIView()
      container.tag = 88
      container.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
      container.backgroundColor = UIColor.black.withAlphaComponent(0.2)
      viewError.backgroundColor = UIColor.white
      //      viewError.center = self.view.convert(self.view.center, from: self.view.superview)
      viewError.button_send.addTarget(self, action: #selector(buttonOKTapped), for: .touchUpInside)
      viewError.button_cancel.addTarget(self, action: #selector(buttonNoTapped), for: .touchUpInside)
      
      friendSearchXib = viewError
      container.addSubview(friendSearchXib)
      self.view.addSubview(container)
      
      friendSearchXib.table_findFriend.reloadData()
    }
  }
  
  
  func showAlert( message: String){
    
    // the alert view
    let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
    self.present(alert, animated: true, completion: nil)
    
    //    AppDelegate.getInstatnce().window?.rootViewController?.present(alert, animated: true, completion: nil)
    //    self.present(alert, animated: true, completion: nil)
    
    // change to desired number of seconds (in this case 5 seconds)
    let when = DispatchTime.now() + 2
    
    DispatchQueue.main.asyncAfter(deadline: when){
      // your code with delay
      alert.dismiss(animated: true, completion: nil)
    }
  }
  
	@objc func buttonOKTapped(){
    
    if Utilities.isValidEmail(testStr: friendSearchXib.textfield_email.text!) {
      
      Utilities.showLoader(controller: self)
      
      let userDict = ["userID" : User.getUserID(),
                      "frID" : friendSearchXib.textfield_email.text!,
                      "spID":voucher.sp_ID!,
                      "vcID":self.array_vouchers] as [String : Any]
      
      ServiceWrapper.vouchPingCall(requestObject: userDict as NSDictionary) {
        (success, response) in
        print("response = %@", response);
        
        if success{
          
          if  let container =  UIApplication.shared.keyWindow?.viewWithTag(88) {
            self.friendSearchXib.removeFromSuperview()
            container.removeFromSuperview()
            
            
            self.view_msg.isHidden = true
            self.is_selection_mode_pings = false
            self.array_vouchers.removeAll()
            self.tableview_offer.reloadData()
            
            let msg = response.value(forKey: "desc") as! String
            Utilities.showToast(error: msg, controller: self)
            self.viewDidLoad()
            
          }
        }else{
          print("Failed")
          
          if  let container =  UIApplication.shared.keyWindow?.viewWithTag(88) {
            self.friendSearchXib.removeFromSuperview()
            container.removeFromSuperview()
            
            self.view_msg.isHidden = true
            self.is_selection_mode_pings = false
            self.array_vouchers.removeAll()
            self.tableview_offer.reloadData()
            
            let msg = response.value(forKey: "desc") as! String
            Utilities.showToast(error: msg, controller: self)
          }
        }
      }
      
    }else if let friendID = friend.au_ID {
      
      Utilities.showLoader(controller: self)
      
      let userDict = ["userID" : User.getUserID(),
                      "frID" : friendID,
                      "spID":voucher.sp_ID!,
                      "vcID":array_vouchers] as [String : Any]
      
      ServiceWrapper.vouchPingCall(requestObject: userDict as NSDictionary) {
        (success, response) in
        print("response = %@", response);
        
        if success{
          
          if  let container =  UIApplication.shared.keyWindow?.viewWithTag(88) {
            self.friendSearchXib.removeFromSuperview()
            container.removeFromSuperview()
            
            
            self.view_msg.isHidden = true
            self.is_selection_mode_pings = false
            self.array_vouchers.removeAll()
            self.tableview_offer.reloadData()
            
            let msg = response.value(forKey: "desc") as! String
            Utilities.showToast(error: msg, controller: self)
            
          }
        }else{
          print("Failed")
          
          if  let container =  UIApplication.shared.keyWindow?.viewWithTag(88) {
            self.friendSearchXib.removeFromSuperview()
            container.removeFromSuperview()
            
            self.view_msg.isHidden = true
            self.is_selection_mode_pings = false
            self.array_vouchers.removeAll()
            self.tableview_offer.reloadData()
            
            let msg = response.value(forKey: "desc") as! String
            Utilities.showToast(error: msg, controller: self)
          }
        }
      }
    }else  {
      Utilities.showToast(error: "Invalid selection or email", controller: self)
    }
  }
  
 @objc func textFieldDidChange(_ textField: UITextField) {
    if textField.tag == 200 {
      print("Email Text is \(String(describing: textField.text))")
    }else if textField.tag == 300 {
      print("Name Text is \(String(describing: textField.text))")      
    }
  }
  
	@objc func buttonNoTapped(){
    if  let container =  UIApplication.shared.keyWindow?.viewWithTag(88) {
      
      UIView.animate(withDuration: 0.5,
                     delay: 0,
					 options: UIView.AnimationOptions.curveEaseOut,
                     animations: { () -> Void in
                      
                      container.center = CGPoint(x: container.center.x, y: container.center.y*5)
                      
      }, completion: { (finished) -> Void in
        
        self.friendSearchXib.removeFromSuperview()
        container.removeFromSuperview()
      })
    }
  }
  
  @IBAction func showInviteView(_ sender: UIButton) {
    
    let storyBoard = UIStoryboard(name: "Main-Pso", bundle: nil)
    let viewController =   storyBoard.instantiateViewController(withIdentifier: "InviteViewController") as! InviteViewController
    viewController.hidesBottomBarWhenPushed = true

    self.navigationController?.pushViewController(viewController, animated: true)
  
    }
  
  @IBAction func showPriceAlert(_ sender: UIButton) {
  
    }
  
  @IBAction func showShareAlert(_ sender: UIButton) {
 
    }
  
  @IBAction func showCallAlert(_ sender: UIButton) {
    print("Phone number is \(String(describing: self.company.number))")
    self.callNumber(phoneNumber: self.company.number!)
  }
  
  private func callNumber(phoneNumber:String) {
    
    if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
      
      let application:UIApplication = UIApplication.shared
      if (application.canOpenURL(phoneCallURL)) {
        if #available(iOS 10.0, *) {
          application.open(phoneCallURL, options: [:], completionHandler: nil)
        } else {
          // Fallback on earlier versions
        }
      }
    }
  }
  
  func updateLocation() {
    print("My Location is \(String(describing: self.location?.locations))")
    tableview_offer.reloadData()
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  func redeemIsSuccessful (ref: String) {
    
    UIApplication.shared.endIgnoringInteractionEvents()
    
    container.removeFromSuperview()
    container = UIView()
    
    container.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    
	let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = self.view.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    blurEffectView.alpha = 0.6
    
    container.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    
    // let height = Utilities.convertIphone6ToIphone5(size: 400.0)
    
    
    
    
    let viewWidth = Utilities.convertIphone6ToIphone5( size: self.view.frame.size.width /  1.21)
    var height = Utilities.convertIphone6ToIphone5(size: 460.0)
    
    var y_axis: CGFloat = -40
    
    if IS_IPHONE_5 {
      y_axis = Utilities.convertIphone6ToIphone5(size: -30)
      height = Utilities.convertIphone6ToIphone5(size: 370.5)
    }
    else{
      y_axis = Utilities.convertIphone6ToIphone5(size: y_axis )
      height = Utilities.convertIphone6ToIphone5(size: 460.0)
      
    }
    let redeemView = SucessRedeemView(frame: CGRect(x: (self.view.frame.midX - viewWidth/2), y: y_axis, width: viewWidth , height:height))
    
    
    //  redeemView = SucessRedeemView(frame: CGRect(x: 0, y: -40, width: self.view.frame.size.width / 1.21 , height: height))
    print(" the width is \(redeemView.frame.width) , the height is \(redeemView.frame.height)")
    redeemView.delegate = self
    
    let url = URL(string: company.logo!)
    
    redeemView.image_logo.kf.setImage(with: url)
    redeemView.label_description.setHtml(voucher.desc!)
    redeemView.label_description.textAlignment = .center
    redeemView.label_customerName.text = "Refrence Number \n \(ref)"
    //redeemView.backgroundColor = UIColor.clear
    print(" the width is \(redeemView.frame.width) , the height is \(redeemView.frame.height)")
    redeemView.center = container.center
    container.addSubview(redeemView)
    
    self.view.addSubview(container)
    
    //    UIApplication.shared.keyWindow?.addSubview(container)
    
  }
  
  func redeemIsFailed (desc: String) {
    
    UIApplication.shared.endIgnoringInteractionEvents()
    
    // the alert view
    let alert = UIAlertController(title: "", message: desc, preferredStyle: .alert)
    
    let alertWindow = UIWindow(frame: UIScreen.main.bounds)
    alertWindow.rootViewController = UIViewController()
	alertWindow.windowLevel = UIWindow.Level.alert + 1
    alertWindow.makeKeyAndVisible()
  //  alertWindow.rootViewController?.present(alert, animated: true) { _ in }
	alertWindow.rootViewController?.present(alert, animated: true, completion: nil)
    
    //    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    
    //    AppDelegate.getInstatnce().window?.rootViewController?.present(alert, animated: true, completion: nil)
    //    self.present(alert, animated: true, completion: nil)
    
    // change to desired number of seconds (in this case 5 seconds)
    let when = DispatchTime.now() + 2
    
    DispatchQueue.main.asyncAfter(deadline: when){
      // your code with delay
      alert.dismiss(animated: true, completion: nil)
    }
    
	container.sendSubviewToBack(alert.view)
    redeemPinView.wrongServiceProviderPin(error: desc)
  }
	
	func redeemGetsFailed (desc: String) {
		UIApplication.shared.endIgnoringInteractionEvents()

		let desc = desc
		let alert = UIAlertController(title: "", message: desc, preferredStyle: .alert)
		self.present(alert, animated: false, completion: nil)
		let when = DispatchTime.now() + 2
		DispatchQueue.main.asyncAfter(deadline: when){
			// your code with delay
			alert.dismiss(animated: true, completion: nil)
			self.redeemPinView.inputField.becomeFirstResponder()

		}
	}
  
  @IBAction func didDollarButton(_ sender: UIButton) {
    button_send_cancel.setTitle("Cancel", for: .normal)
    self.view_msg.isHidden = false
    is_selection_mode_reimburse = true
    
  }
  
  @IBAction func didShareButton(_ sender: UIButton) {
    displayShareSheet(shareContent: "Fancy going to \(String(describing: company.array_vouchers[0].sp_ID!)), head over to Vouch365 and check their discount offers [link:https://www.vouch365.com/outlets/\(String(describing: company.array_vouchers[0].sp_ID!))]");
  }
  
  func displayShareSheet(shareContent:String) {
    let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
    present(activityViewController, animated: true, completion: {}
    )
  }
  
  func callTextField(){
    
  }
  func closeView(){
    
    print("close view")
    
  }
}

// MARK: - UITableViewDelegate

extension OfferViewController : UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    switch indexPath.row {
    case 0:
      return 40
    case 1:
      return 40
    case 2:
      return 60
    default:
      return 60
    }
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
    
    if is_selection_mode_pings {
      
    }else if is_selection_mode_reimburse {
      
		let alertController = UIAlertController(title: "Reimburse Voucher", message: "Are you sure you want to reimburse this voucher", preferredStyle: UIAlertController.Style.alert)
		let okAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
        (result : UIAlertAction) -> Void in
        print("Cancel")
      }
      
		let callAction = UIAlertAction(title: "Done", style: UIAlertAction.Style.default) {
        (result : UIAlertAction) -> Void in
        
        let voucher = self.company.array_vouchers [indexPath.row-2]
        self.reimbuserVoucher(voucher: voucher)
      }
      
      alertController.addAction(okAction)
      alertController.addAction(callAction)
      self.present(alertController, animated: true, completion: nil)
      
    }else {
      if indexPath.row == 0 {
        delegate?.showLocations()
      }
      else if indexPath.row == 1 {
        
        return
      }else{
        voucher = company.array_vouchers [indexPath.row-2]
        self.showPopup(_voucher: voucher)
      }
    }
  }
  
  func showPopup(_voucher : VoucherData) {
    
    /*if (User.getUserID() == "1"){
      // perhaps use action.title here
      Bootstrapper.reset()
      Bootstrapper.showLogin()
      
      return
    }*/
     if (_voucher.redeemed)! {
		let alertController = UIAlertController(title: "Vouch365", message: "Already Redeemed", preferredStyle: UIAlertController.Style.alert)
		let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
        (result : UIAlertAction) -> Void in
        print("OK")
      }
      
      alertController.addAction(okAction)
      self.present(alertController, animated: true, completion: nil)
      return
    }
    container = UIView()
    
    container.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
    
	let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = self.view.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    blurEffectView.alpha = 0.6
    
    container.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    
    let viewWidth = Utilities.convertIphone6ToIphone5( size: self.view.frame.size.width /  1.21)
    var height = Utilities.convertIphone6ToIphone5(size: 400.0)
    
    var y_axis: CGFloat = -40
    
    if IS_IPHONE_5 {
      y_axis = Utilities.convertIphone6ToIphone5(size: 30)
      height = Utilities.convertIphone6ToIphone5(size: 380.5)
    }
    else{
      y_axis = Utilities.convertIphone6ToIphone5(size: y_axis)
      height = Utilities.convertIphone6ToIphone5(size: height)
      
    }
    
    let  redeemView = RedeemView(frame: CGRect(x: (self.view.frame.midX - viewWidth/2), y: y_axis, width: viewWidth , height:height))
    
    
    //    let height = Utilities.convertIphone6ToIphone5(size: 400.0)
    //    let redeemView = RedeemView(frame: CGRect(x: 0, y: -40, width: Utilities.convertIphone6ToIphone5(size: self.view.frame.size.width / 1.21) , height: height))
    print(" the width is \(redeemView.frame.width) , the height is \(redeemView.frame.height)")
    redeemView.delegate = self
    
    let url = URL(string: company.logo!)
    
    redeemView.image_logo.kf.setImage(with: url)
    redeemView.label_description.setHtml(voucher.desc!)
    redeemView.label_description.textAlignment = .center
    
    redeemView.label_customerName.text = "Customer Name: \(User.getFirstName())"
    redeemView.label_customerSaving.text = "Savings: \(_voucher.savings!)"
    if voucher.eligibility!   {
      redeemView.button_redeem.setTitle("Redeem", for: .normal)
    }
    else {
      redeemView.button_redeem.setTitle("Purchase", for: .normal)
    }
    redeemView.backgroundColor = UIColor.clear
    print(" the width is \(redeemView.frame.width) , the height is \(redeemView.frame.height)")
    redeemView.center = container.center
    container.addSubview(redeemView)
    
    self.view.addSubview(container)
    
    //    UIApplication.shared.keyWindow?.addSubview(container)
  }
}

extension OfferViewController : UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return company.array_vouchers.count+2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.row {
    case 0:
      //cell_location
      let cell = tableView.dequeueReusableCell(withIdentifier: "AreaTableViewCell") as! AreaTableViewCell
      cell.label_areaname.text = self.location?.locality
	  cell.tintColor = UIColor.white
      return cell
    case 1:
      //cell_header
      
      let date = Date()
      let calendar = Calendar.current
      let components = calendar.dateComponents([.year, .month, .day], from: date)

      let year =  components.year
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "OfferedInProductTableViewCell") as! OfferedInProductTableViewCell
      
      cell.label_offer.text = "OFFER  CONTAINED IN PRODUCT"

      if let year = company.Year, let city = company.Caps_City {
        cell.label_title.text = "\(city) \(year)"
      }
      
      return cell
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: "VoucherTableViewCell") as! VoucherTableViewCell
      let voucher = company.array_vouchers [indexPath.row-2]
      cell.delegate = self
      cell.button_checkbox.tag = indexPath.row-2
      
      if is_selection_mode_pings == true {
        cell.button_checkbox.isHidden = false
        
        if array_vouchers.contains(voucher.vc_ID!)   {
          print("Found")
          cell.button_checkbox.setImage(UIImage(named: "check")!, for: .normal)
        }else {
          cell.button_checkbox.setImage(UIImage(named: "uncheck")!, for: .normal)
        }
      }else {
        cell.button_checkbox.isHidden = true
      }
      
      if voucher.redeemed! {
        cell.imageview_voucher.image = UIImage(named:"redeem_tick")
        cell.label_description.text = "Already Redeemed"
        
      }else {
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year =  components.year
        
        //let url = URL(string: "\(company.logo!)")
        //cell.imageview_voucher.kf.setImage(with: url)
        cell.label_description.text = "Valid Until 30 Dec \(year!)"
        
        if company.category == "restaurant" {
          cell.imageview_voucher.image = UIImage(named:"icon_food")
        }
        else if company.category == "kids" {
          cell.imageview_voucher.image = UIImage(named:"icon_health")
        }
        else if company.category == "leisure" {
          cell.imageview_voucher.image = UIImage(named:"icon_leisure")
        }
        else if company.category == "body" {
          cell.imageview_voucher.image = UIImage(named:"icon_saloon")
        }
        else if company.category == "services" {
          cell.imageview_voucher.image = UIImage(named:"icon_service")
        }
        else if company.category == "travel" {
          cell.imageview_voucher.image = UIImage(named:"icon_travel")
        }
        
        
      }
      
      cell.label_title.text = voucher.name
      
      return cell
    }
  }
}

extension OfferViewController: DashboardOfferBannerCellDelegate {
  func didSelectIndexAtBanner(index: Voucher) {
    // tableView.deselectRow(at: indexPath, animated: true)
  }
}

extension OfferViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerImageCollectionViewCell", for: indexPath) as! BannerImageCollectionViewCell
    
    let url = URL(string: "\(company.header!)")
    cell.imageview_header.kf.setImage(with: url)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
    //    let totalSpace = flowLayout.sectionInset.left
    //      + flowLayout.sectionInset.right
    //      + (flowLayout.minimumInteritemSpacing * CGFloat(1 - 1))
    let size = Int(collectionView.bounds.width )
    return CGSize(width: size, height: 200)
  }
  
}

extension OfferViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("INdex Path in collectionView \(indexPath.row)")
  }
}

extension OfferViewController: RedeemViewDelegate {
  
  func didCloseView() {
    container.removeFromSuperview()
	self.view.endEditing(true)
  }
  
  func showInputViewRedeem(eligible: Bool) {
    container.removeFromSuperview()
    
  
    
    container = UIView()
	container.frame = CGRect(x: 0, y: 30, width: self.view.frame.size.width, height: self.view.frame.height)

    //container.frame = CGRect(x: 0, y: 30, width: self.view.frame.size.width, height: (UIApplication.shared.keyWindow?.frame.height)!)
    
	let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = self.view.bounds
    blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    blurEffectView.alpha = 0.6
    
    container.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    
    let viewWidth = Utilities.convertIphone6ToIphone5( size: self.view.frame.size.width /  1.21)
    var height = Utilities.convertIphone6ToIphone5(size: 460.0)
    
    var y_axis: CGFloat = 0
    
    if IS_IPHONE_5 {
      y_axis = Utilities.convertIphone6ToIphone5(size: 30)
      height = Utilities.convertIphone6ToIphone5(size: 370.5)
    }
    else if IS_IPHONE_X{
        
        y_axis = 10
        height = 460.0
        
    }
    else{
      y_axis = Utilities.convertIphone6ToIphone5(size: 10)
      height = Utilities.convertIphone6ToIphone5(size: 460.0)
      
    }
    
   
    
    redeemPinView = RedeemPinView(frame: CGRect(x: (self.view.frame.midX - viewWidth/2), y: y_axis, width: viewWidth , height:height))
    redeemPinView.delegate = self
    
    let url = URL(string: company.logo!)
    redeemPinView.image_logo.kf.setImage(with: url)
    redeemPinView.label_description.setHtml(voucher.desc!)
    redeemPinView.label_description.textAlignment = .center
    
    redeemPinView.label_customerName.text = "Customer Name: \(User.getFirstName())"
    redeemPinView.label_customerSaving.text = "Savings: \(self.company.array_vouchers[0].savings!)"
    
    redeemPinView.backgroundColor = UIColor.clear
    container.addSubview(redeemPinView)
    
    self.view.addSubview(container)
	self.view.bringSubviewToFront(container)
	self.container.bringSubviewToFront(redeemPinView)
    
    UIApplication.shared.keyWindow?.addSubview(container)
  }
}

extension OfferViewController: RedeemPinViewDelegate {
  func didClosePinView() {
	self.view.endEditing(true)
	redeemPinView.resignFirstResponder()
    redeemPinView.inputField.resignFirstResponder()
    container.removeFromSuperview()
  }
  
  func requestServerWithPin(pin: String) {
    delegate?.getRedeem(pin: pin, vc_ID: voucher.vc_ID!, userID: User.getUserID(), sp_ID: (location?.sp_ID)!, savings: voucher.savings!)
  }
}
extension OfferViewController : SucessRedeemViewDelegate {
  func doneClicked() {
    redeemPinView.inputField.resignFirstResponder()
    container.removeFromSuperview()
    delegate?.reloadView(sp_id: (location?.sp_ID)!, user_id: User.getUserID())
    didShareButton(UIButton())
  }
  
  func didCloseSucessView() {
    container.removeFromSuperview()
  }
}

extension String {
  
  var html2AttributedString: NSAttributedString? {
    guard
      let data = data(using: String.Encoding.utf8)
      else { return nil }
    do {
		let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html,
            NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue
        ]
      //return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:String.Encoding.utf8], documentAttributes: nil)
		return try NSAttributedString(data: data, options: options, documentAttributes: nil)
    } catch let error as NSError {
      print(error.localizedDescription)
      return  nil
    }
  }
  var html2String: String {
    return html2AttributedString?.string ?? ""
  }
}

extension OfferViewController : UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    friendSearchXib.table_findFriend.isHidden = true
    
    if textField.tag == 200 {
      textField.resignFirstResponder()
    }else if textField.tag == 300 {
      textField.resignFirstResponder()
    }
    return false
  }
}

extension OfferViewController : FriendSearchViewDelegate {
  func passFriend(friend: Friend) {
    self.friend = friend
  }
}


extension OfferViewController : VoucherDelegate {
  
  func didSelectVoucher(index: Int) {
    let voucher = self.company.array_vouchers[index]
    print("Index is \(voucher)")
    let vc_ID = voucher.vc_ID
    
    var exists = false
    for voucher_check in self.array_vouchers {
      //for loop iterates through all Strings in the array
      if (voucher_check == vc_ID) {
        // found the one we are looking for
        print("found")
        exists = true
        break
      }
    }
    
    print("Index is seleced button \(index)")
    
    if exists {
      array_vouchers.remove(object: vc_ID!)
    }else {
      array_vouchers.append(vc_ID!)
    }
    print("Papu is \(self.array_vouchers)")
    self.tableview_offer.reloadData()
  }
}



extension Array where Element: Equatable {
  
  // Remove first collection element that is equal to the given `object`:
  mutating func remove(object: Element) {
    if let index = index(of: object) {
      remove(at: index)
    }
  }
}

