//
//  HomeViewController.swift
//  Voucher365
//
//  Created by Veer Suthar on 3/4/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit
import MessageUI
import MapKit
import IQKeyboardManagerSwift
import ObjectMapper
import GoogleMaps
import GooglePlaces

public class HomeViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate {
	
	@IBOutlet weak var citySelection: SelectionView!
	@IBOutlet weak var searchTableView: UITableView!
	
	@IBOutlet weak var collectionview_header: UICollectionView!
	@IBOutlet weak var tableview_home: UITableView!
	
	@IBOutlet weak var view_connect: UIView!
	@IBOutlet weak var searchView: UIView!
	@IBOutlet weak var lblCityName: UILabel!
	@IBOutlet var selectionView: SelectionView!
	let lat : Double! =  24.861462
	let lon : Double! = 67.064331
	var dummySearchResultArray = Array<Offer>()
	var categories = ["", "More to enjoy", "Featured"]
	var company: CompanyDetail = CompanyDetail()
	
	@IBOutlet weak var constraint_heightCollection: NSLayoutConstraint!
	//  var array_cat = ["Food & Drinks","Salon & Spa","Leisure","Health Care","Retail & Services","Travel"]
	//  var array_images = ["icon_food","icon_saloon","icon_leisure","icon_health","icon_service","icon_travel"]
	
	var array_cat = ["Food & Drinks","Salon & Spa","Leisure","Health Care","Retail & Services","Travel"]
	let categoryType = ["restaurant","body","leisure","kids","services","travel"]
	
	
	@IBOutlet weak var searchButton: UIButton!
	let searchController = UISearchController(searchResultsController: nil)
	
	var array_featured: Array <Voucher> = []
	var array_new: Array <Voucher> = []
	var array_top: Array <Voucher> = []
	
	var homesaving: HomeSaving = HomeSaving()
	
	
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		
		// IQKeyboardManager.sharedManager().enable = true
		IQKeyboardManager.shared.enable = true
		
		let vw = UIView()
		vw.backgroundColor = UIColor.clear
		vw.frame =  CGRect(x: 0, y:0 , width: self.view.frame.size.width, height: 20)
		self.tableview_home.tableFooterView  =  vw
		self.InitializeImpContent()
		let user = User.getCity()
		lblCityName.text = "\(user.capitalizingFirstLetter()) ⬇︎"
		
		getCities()
		fetchHomeData()
		fetchPopUpData()
		
		searchController.dimsBackgroundDuringPresentation = false
		definesPresentationContext = true
		searchController.searchBar.tintColor = UIColor.white
		self.searchView.addSubview(searchController.searchBar)
		searchController.delegate = self
		searchController.searchBar.delegate = self
		searchController.searchBar.placeholder = "Quick search by name or keyword"
		searchController.searchBar.alpha = 0.0
		constraint_heightCollection.constant = Utilities.convertIphone6ToIphone5(size: constraint_heightCollection.constant)
		self.updateViewConstraints()
		//self.tableview_home.register(HomeVendorLogoTableViewCell.self, forCellReuseIdentifier: "HomeVendorLogoTableViewCell")
		
		
	}
	//Searchbar Delegate Methods
	@IBAction func didTapOnSearch(_ sender: Any) {
		
		// selectionView.isHidden = false
		
		//   selectionView.selectionViewDelegate = self
		searchController.searchBar.alpha = 1.0
		searchController.searchBar.becomeFirstResponder()
		searchTableView.isHidden = false
	}
	
	@IBAction func didTapOnCross(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
		//self.navigationController?.dismiss(animated: true, completion: nil)
	}
	
	public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		//searchController.searchBar.removeFromSuperview()
		//searchView.willRemoveSubview(searchBar)
		searchBar.alpha = 0.0
		searchTableView.isHidden = true
		dummySearchResultArray.removeAll()
		searchTableView.reloadData()
		
	}
	public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		//let filteredArray = self.dummySearchArray.filter { $0.localizedCaseInsensitiveContains(searchText) }
	}
	
	public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		if (searchBar.text?.count)! >= 3 {
			self.searchData(keyword:searchBar.text!)
		}
	}
	//End of Searchbar Delegate Methods
	
	func InitializeImpContent(){
		GMSServices.provideAPIKey("AIzaSyB4ocLpkc5F2-3G4bts4nZg9m2WQKiOOLY")
		GMSPlacesClient.provideAPIKey("AIzaSyB4ocLpkc5F2-3G4bts4nZg9m2WQKiOOLY")
		let city = User.getCity()
		if city.count == 0 {
			User.setCityName(city: "karachi")
		}
		User.setViewName(viewName: "List")
	}
	
	@IBAction func didSelectCity(_ sender: UIButton) {
		citySelection.frame = CGRect(x: 0, y:  self.view.frame.size.height - 150, width: self.view.frame.size.width, height: 150)
		
		//sdk commit
		//AppDelegate.getInstatnce().window?.addSubview(citySelection)
		//sdk change
		self.view.addSubview(citySelection)
		//HomeViewController.getInstatnce().window?!.addSubview(citySelection)
		
		citySelection.selectionViewDelegate = self
	}
	
	func showRedeem()  {
		
		let container: UIView = UIView()
		container.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: (UIApplication.shared.keyWindow?.frame.size.height)!)
		
		let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = self.view.bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		blurEffectView.alpha = 0.6
		// container.addSubview(blurEffectView)
		
		container.backgroundColor = UIColor.black.withAlphaComponent(0.8)
		
		let redeemView = RedeemView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 1.21 , height: 400))
		
		
		print(" the width is \(redeemView.frame.width) , the height is \(redeemView.frame.height)")
		redeemView.center = container.center
		
		
		container.addSubview(redeemView)
		
		UIApplication.shared.keyWindow?.addSubview(container)
		
	}
	func fetchHomeData() {
		
		let requestObject: NSDictionary = ["userID":"03124578451"]
		
		Utilities.showLoader(controller: self)
		
		ServiceWrapper.getSliderData(requestObject: requestObject, type: "Hello") {
			(success, response) in
			
			if success{
				
				let data = response.value(forKey: "data") as? Dictionary<String, Any>
				
				let featured = response.value(forKey: "featured") as? Array<Dictionary<String, Any>>
				let new = response.value(forKey: "new") as? Array<Dictionary<String, Any>>
				let top = response.value(forKey: "top") as? Array<Dictionary<String, Any>>
				
				self.homesaving.redCount = data?["redCount"] as? String
				self.homesaving.savings = data?["savings"] as? String
				self.homesaving.smilesEarned = data?["smilesEarned"] as? String
				
				self.array_featured = Voucher.getArrayOfVoucher(array: featured ?? [])
				self.array_new = Voucher.getArrayOfVoucher(array: new ?? [])
				self.array_top = Voucher.getArrayOfVoucher(array: top ?? [])
				
				self.tableview_home.reloadData()
				self.collectionview_header.reloadData()
				
			}
		}
		
	}
	
	func fetchPopUpData() {
		
		let requestObject: NSDictionary = ["userID":User.getUserID()]
		
		Utilities.showLoader(controller: self)
		
		ServiceWrapper.getPopUpData(requestObject: requestObject) {
			(success, response) in
			
			if success{
				print(response)
				var popupObj: PopUP = PopUP()
				popupObj.setDataFromServer(dict: response)
				if popupObj.image != nil{
					let popUpVc = FullScreenPopUpViewController.instantiateFromStoryboard()
					popUpVc.popupModel = popupObj
					self.present(popUpVc, animated: true, completion: nil)
				}
				
			}else{
				print(response)
				var popupObj: PopUP = PopUP()
				
				popupObj.setDataFromServer(dict: response)
				if popupObj.image != nil{
					let popUpVc = FullScreenPopUpViewController.instantiateFromStoryboard()
					popUpVc.popupModel = popupObj
					self.present(popUpVc, animated: true, completion: nil)
				}
			}
		}
	}
	
	
	override public func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.setNavigationBarHidden(true, animated: true)
		self.tabBarController?.tabBar.isHidden = true

		
	}
	
	func showPINView()  {
		
		let container: UIView = UIView()
		container.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: (UIApplication.shared.keyWindow?.frame.size.height)!)
		
		let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = self.view.bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		blurEffectView.alpha = 0.6
		// container.addSubview(blurEffectView)
		
		container.backgroundColor = UIColor.black.withAlphaComponent(0.8)
		
		
		let redeemView = VSPINView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 1.21 , height: 500))
		
		redeemView.backgroundColor = UIColor.clear
		
		print(" the width is \(redeemView.frame.width) , the height is \(redeemView.frame.height)")
		redeemView.center = container.center
		
		
		container.addSubview(redeemView)
		
		UIApplication.shared.keyWindow?.addSubview(container)
		
	}
	
	override public func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func didShowSelection(_ sender: UIButton) {
		
		//  let selection_view = SelectionView.instanceFromNib()
		// self.view.addSubview(selection_view)
	}
	
	@IBAction func makeACall(_ sender: UIButton) {
		
		self.callNumber(phoneNumber: "021-111-486-824")
		
		//    let alertController = UIAlertController(title: "Call Helpline?", message: "021-111-486-824", preferredStyle: UIAlertControllerStyle.alert)
		//    let okAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
		//      (result : UIAlertAction) -> Void in
		//      print("Cancel")
		//    }
		//
		//    let callAction = UIAlertAction(title: "Call", style: UIAlertActionStyle.default) {
		//      (result : UIAlertAction) -> Void in
		//      print("Call")
		//      self.callNumber(phoneNumber: "021-111-486-824")
		//    }
		//
		//    alertController.addAction(okAction)
		//    alertController.addAction(callAction)
		//
		//    self.present(alertController, animated: true, completion: nil)
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
	
	@IBAction func sendEmail(_ sender: UIButton) {
		let mailComposeViewController = configuredMailComposeViewController()
		if MFMailComposeViewController.canSendMail() {
			self.present(mailComposeViewController, animated: true, completion: nil)
		} else {
			self.showSendMailErrorAlert()
		}
	}
	
	
	func configuredMailComposeViewController() -> MFMailComposeViewController {
		let mailComposerVC = MFMailComposeViewController()
		mailComposerVC.mailComposeDelegate = self
		mailComposerVC.setToRecipients(["support@vouch365.com"])
		mailComposerVC.setSubject("Support")
		//    mailComposerVC.setMessageBody("", isHTML: false)
		
		return mailComposerVC
	}
	
	func showSendMailErrorAlert() {
		let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
		sendMailErrorAlert.show()
	}
	
	///////   Call Search Service
	
	func searchData(keyword:String) {
		
		Utilities.showLoader(controller: self)
		
		ServiceWrapper.searchCall(search_text: keyword) { (sucess, response) in
			if sucess {
				let array = response.value(forKey: "data") as! NSArray
				
				print("data  \(array)")
				
				self.dummySearchResultArray.removeAll()
				print("Final Favourite is \(array)")
				
				var offer = Offer()
				if ((array.count) > 0) {
					for index in 0...(array.count)-1 {
						offer = Offer()
						offer.setDataFromServer(dict: (array.object(at: index) as? NSDictionary)!)
						self.dummySearchResultArray.append(offer)
					}
					self.searchTableView.reloadData()
				}
				
				//   var offerService = Offer()
				// print("Response from service \(offerService.setDataFromServer(dict: data.value(forKey: "dict") as! NSDictionary))")
			}
		}
	}
	
	func fetchCompanyDetail(sp_id: String, user_id: String) {
		
		Utilities.showLoader(controller: self)
		
		ServiceWrapper.getCompanyDetail(sp_id: sp_id, user_id: user_id) {
			(success,response) in
			if success{
				print(response)
				
				self.citySelection.removeFromSuperview()
				
				var local_company: CompanyDetail = CompanyDetail()
				local_company.setDataFromServer(response)
				
				self.company = local_company
				
				//        let navigation:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NavigationRootOfferDetailsViewController") as! UINavigationController
				//let viewController = navigation.viewControllers.first as! RootOfferDetailsViewController
				//self.navigationController?.present(navigation, animated: true, completion: nil)
				
				let viewController:RootOfferDetailsViewController = UIStoryboard(name: "Main-Pso", bundle: nil).instantiateViewController(withIdentifier: "RootOfferDetailsViewController") as! RootOfferDetailsViewController
				
				viewController.company = self.company
				viewController.hidesBottomBarWhenPushed = true
				self.navigationController?.pushViewController(viewController, animated: true)
			}
		}
	}
	
	
	///////End Of Search Service
}

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate{
	public func scrollViewDidScroll(_ scrollView: UIScrollView){
		
	}
	
	public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
		
	}
}


/*extension HomeViewController : UITableViewDelegate {

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
if tableView == searchTableView {
return 70
}
else {
switch indexPath.section {
case 0:
return 95
case 1:
return 235
case 2:
return 235
default:
return 0
}
}
}
}*/

extension HomeViewController : UITableViewDataSource,UITableViewDelegate {
	public func numberOfSections(in tableView: UITableView) -> Int {
		if tableView == searchTableView {
			return 1
		}
		return 2
	}
	
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tableView == searchTableView {
			return dummySearchResultArray.count
		}
		return 1
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = UITableViewCell()
		
		print("Index Path \(indexPath.section) + \(indexPath.row)")
		
		if tableView == searchTableView {
			
			let cell = tableView.dequeueReusableCell(withIdentifier: "homeSearchCell") as! CategoryTableViewCell
			
			let offerDao = dummySearchResultArray[indexPath.row]
			cell.label_title.text = offerDao.name
			//      if let desci = offerDao.desc{
			//        cell.offer_desc.text = desci
			//      }
			let url = URL(string: offerDao.logo!)
			cell.imageview_logo.kf.setImage(with: url)
			let userLocation = CLLocation(latitude:Double(lat), longitude: Double(lon))
			cell.label_distance.text = Utilities.getDistanceInKM(lat1: Double(offerDao.latitude!)!, lon1: Double(offerDao.longitude!)!, lat2: userLocation.coordinate.latitude, lon2: userLocation.coordinate.longitude, unit: "K")
			//      cell.label_distance.text = Utilities.getDistanceInKM(lat: Double(offerDao.latitude!)!, lon: Double(offerDao.longitude!)!, userLocation: userLocation)
			// cell.label_distance.text = "15KM away"
			cell.label_location.text = offerDao.locality!
			
			//cell.offer_image.image = UIImage(named:"icon_food")
			if offerDao.category == "restaurant" {
				
				cell.small_icon.image = UIImage(named:"icon_food")
			}
			else if offerDao.category == "kids" {
				cell.small_icon.image = UIImage(named:"icon_health")
			}
			else if offerDao.category == "leisure" {
				cell.small_icon.image = UIImage(named:"icon_leisure")
			}
			else if offerDao.category == "body" {
				cell.small_icon.image = UIImage(named:"icon_saloon")
			}
			else if offerDao.category == "services" {
				cell.small_icon.image = UIImage(named:"icon_service")
			}
			else if offerDao.category == "travel" {
				cell.small_icon.image = UIImage(named:"icon_travel")
			}
			
			return cell
		}
		else {
			if indexPath.section == 0 {
				let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardOfferIconCell") as! DashboardOfferIconCell
				cell.delegate = self
				return cell
			}else if indexPath.section == 1{
				let cell = tableView.dequeueReusableCell(withIdentifier: "HomeVendorLogoTableViewCell") as! HomeVendorLogoTableViewCell
				cell.vendorLogo.image = UIImage(named:"vouch_pso_logo")
				return cell
			}
			else if indexPath.section == 2{
				let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardOfferBannerCell") as! DashboardOfferBannerCell
				
				print("Array of featured news: \(array_featured)")
				cell.array_collection = array_new
				//cell.label_title.text = "More to enjoy"
				cell.label_title.isHidden = true
				cell.delegate = self
				cell.collectionView.reloadData()
				return cell
				
			}else if indexPath.section == 2 {
				
				let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardOfferBannerCell") as! DashboardOfferBannerCell
				
				print("Array of new \(array_new)")
				cell.array_collection = array_featured
				cell.label_title.text = "Featured"
				cell.imageView_happily.isHidden = true
				cell.delegate = self
				cell.collectionView.reloadData()
				return cell
			}
		}
		
		return cell
	}
	
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if tableView == searchTableView{
			let category : Offer = dummySearchResultArray[indexPath.row]
			fetchCompanyDetail(sp_id: category.sp_ID!,user_id: User.getUserID())
		}
		
	}
	
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if tableView == searchTableView {
			return 70
		}
		else {
			switch indexPath.section {
			case 0:
				return 95
			case 1:
				return 235
			case 2:
				return 235
			case 3:
				return 235
			default:
				return 0
			}
		}
	}
	
	
}

extension HomeViewController: DashboardOfferIconCellDelegate {
	
	func didSelectIndexAtIcon(index: Int) {
		
		self.citySelection.removeFromSuperview()
		
		let storyBoard = UIStoryboard(name: "Main-Pso", bundle: nil)
		let viewController =   storyBoard.instantiateViewController(withIdentifier: "RootListMapViewController") as! RootListMapViewController
		
		print(array_cat[index])
		viewController.titleOfController = array_cat[index]
		viewController.argumentToServer = categoryType[index]
		viewController.hidesBottomBarWhenPushed = true
		
		self.navigationController?.pushViewController(viewController, animated: true)
	}
}

extension HomeViewController: DashboardOfferBannerCellDelegate {
	func didSelectIndexAtBanner(index: Voucher) {
		self.citySelection.removeFromSuperview()
		//    let voucher : Voucher = array_top[index]
		
		print("Voucher \(index.linktype!)")
		
		if index.linktype == "url" {
			let url = URL(string: index.url!)
			if UIApplication.shared.canOpenURL(url!) {
				UIApplication.shared.openURL(url!)
			}
		}
		else if index.linktype == "spid" {
			fetchCompanyDetail(sp_id: index.spid!, user_id: User.getUserID())
		}
		else if index.linktype == "tab" {
			print("Index is \(index.tab!)")
			let storyboard = UIStoryboard(name: "Main-Pso", bundle: nil)
			
			let viewController: RootListMapViewController = storyboard.instantiateViewController(withIdentifier: "RootListMapViewController") as! RootListMapViewController
			
			
			//  var array_cat = ["Food & Drinks","Salon & Spa","Leisure","Health Care","Retail & Services","Travel"]
			
			if index.cat! == "restaurant" {
				viewController.titleOfController = "Food & Drinks"
			}
			else if index.cat! == "kids" {
				viewController.titleOfController = "Salon & Spa"
			}
			else if index.cat! == "leisure" {
				viewController.titleOfController = "Leisure"
			}
			else if index.cat! == "body" {
				viewController.titleOfController = "Health Care"
			}
			else if index.cat! == "services" {
				viewController.titleOfController = "Retail & Services"
			}
			else if index.cat! == "travel" {
				viewController.titleOfController = "Travel"
			}
			
			viewController.argumentToServer = index.cat!
			viewController.voucherFromHome = index
			
			viewController.hidesBottomBarWhenPushed = true
			
			self.navigationController?.pushViewController(viewController, animated: true)
			
		}
		
	}
}


extension HomeViewController : UICollectionViewDataSource {
	
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if array_top.count > 0 {
			return array_top.count
		}
		return 0
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerImageCollectionViewCell", for: indexPath) as! BannerImageCollectionViewCell
		let voucher : Voucher = array_top[indexPath.row]
		cell.label_title.text = "Hey \(User.getFirstName()), \(voucher.tag!)"
		//let url = URL(string: "\(Constants.baseUrlStagging)/\(voucher.header!)")
		let url = URL(string: "\(voucher.header!)")

		cell.imageview_header.kf.setImage(with: url)
		return cell
		
	}
	
}

extension HomeViewController: UICollectionViewDelegate {
	
	public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print("INdex Path in collectionView \(indexPath.row)")
	}
}
extension HomeViewController: UICollectionViewDelegateFlowLayout{
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
				return CGSize(width: collectionView.bounds.width, height: Utilities.convertIphone6ToIphone5(size: 296))
	}
	
}

extension UISearchBar {
	func changeSearchBarColor(color : UIColor) {
		for subView in self.subviews {
			for subSubView in subView.subviews {
				
				if let _ = subSubView as? UITextInputTraits {
					let textField = subSubView as! UITextField
					textField.backgroundColor = color
					break
				}
				
			}
		}
	}
}


extension HomeViewController: SelectionViewDelegate{
	
	func setCityName(name: String) {
		lblCityName.text = "\(name.capitalizingFirstLetter())  ⬇︎"
		// lblCityName.text = "\(name.firstUppercased)  ⬇︎"
		
	}
	
	func removeSelectionView(){
		citySelection.removeFromSuperview()
		fetchHomeData()
	}
}


extension HomeViewController: UIApplicationDelegate {
	static func getInstatnce() -> UIApplicationDelegate{
		return UIApplication.shared.delegate as! UIApplicationDelegate
	}
}

extension HomeViewController: MFMailComposeViewControllerDelegate {
	// MARK: MFMailComposeViewControllerDelegate Method
	public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true, completion: nil)
	}
}

extension HomeViewController{
	func getCities() {
		if Utilities.isInternetConnected() {
			ServiceWrapper.getCities() { (sucess, response) in
				if sucess {
					
					if let results = response["data"] as? [Any]{
						let array_cities = Mapper<VouchCity>().mapArray(JSONArray:results as! [[String : Any]])
						for value in array_cities {
							let city =  VouchCity(value: value)
							StorageService.saveCity(realmObject: city)
						}
					}
					
					print("Cities is \(StorageService.getCitiies())")
					let user = User.getCity()
					self.lblCityName.text = "\(user.capitalizingFirstLetter()) ⬇︎"
					self.fetchHomeData()
				}
			}
		}
	}
}




