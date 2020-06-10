//
//  RootOfferDetailsViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/24/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class RootOfferDetailsViewController: UIViewController {
  
  var selectedButtonIndex: Int = 0
  
  var nextSceneOffer: OfferViewController!
  var nextSceneDetails: DetailsViewController!
  
  @IBOutlet weak var button_offer: UIButton!
  @IBOutlet weak var button_details: UIButton!
  
  @IBOutlet weak var view_offer: UIView!
  @IBOutlet weak var view_details: UIView!
  
  @IBOutlet weak var container_offer: UIView!
  @IBOutlet weak var container_details: UIView!
  
  var company: CompanyDetail = CompanyDetail()
  var location: Location?
  
  var favorite: UIButton = UIButton()
  
  var isSelected: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigation()
    
    button_offer.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
    button_details.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
    
    self.navigationItem.title = company.name
    
    if selectedButtonIndex == 0 {
      
      view_offer.backgroundColor = UIColor.init(hex: "FBEA7E")
      view_details.backgroundColor = UIColor.white
      container_offer.isHidden = false
      container_details.isHidden = true
      button_offer.setTitleColor(UIColor.black, for: .normal)
      button_details.setTitleColor(UIColor.gray, for: .normal)
      button_offer.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)
      button_details.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
    }else {
      view_offer.backgroundColor = UIColor.white
      view_details.backgroundColor = UIColor.init(hex: "FBEA7E")
      container_offer.isHidden = true
      container_details.isHidden = false
      button_offer.setTitleColor(UIColor.gray, for: .normal)
      button_details.setTitleColor(UIColor.black, for: .normal)
      button_details.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)
      button_offer.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
    }
    
    
    if (self.company.array_location.count) > 1 {
      showLocations()
    }
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.navigationController?.setNavigationBarHidden(false, animated: true)

  }
  
  func showLocations() {
    let storyBoard = UIStoryboard(name: "Main-Pso", bundle: nil)
    let locationController = storyBoard.instantiateViewController(withIdentifier: "LocationsViewController") as!  UINavigationController
    
    let locationController1 = locationController.viewControllers[0] as! LocationsViewController
    locationController1.array_outlets = self.company.array_location
    locationController1.delegate = self
    self.present(locationController, animated:true, completion: nil)
  }
  
  func pushNewView(location: Location) {
    print("Location is %@", location)
    self.location = location
  }
  
  func pushNewView() {
    
    if self.location != nil {
      self.nextSceneOffer.location = self.location
      self.nextSceneOffer.updateLocation()
      self.nextSceneDetails.location = self.location!
      self.nextSceneDetails.reloadTable()
    }
    
    /*
     if self.location != nil {
     ServiceWrapper.getCompanyDetail(sp_id: (self.location?.sp_ID!)!, user_id: User.getUserID()) {
     (success,response) in
     if success{
     
     print(response)
     
     self.company = CompanyDetail()
     self.company.setDataFromServer(response)
     
     //self.nextSceneOffer.company = self.company
     //self.nextSceneOffer.tableview_offer.reloadData()
     
     //let viewController:RootOfferDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootOfferDetailsViewController") as! RootOfferDetailsViewController
     //          viewController.company = self.company
     //          self.navigationController?.pushViewController(viewController, animated: true)
     }
     }
     }
     */
  }
  
  
  func setupNavigation() {
    
    self.navigationController?.navigationBar.barTintColor = UIColor.white
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    
    self.tabBarController?.tabBar.barTintColor = UIColor.white
    self.tabBarController?.tabBar.isTranslucent = false
    self.tabBarController?.tabBar.backgroundImage = UIImage()
    self.tabBarController?.tabBar.shadowImage = UIImage()
    
	self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 13)!]
    
    let backbutton = UIButton(type: .custom)
    backbutton.setImage(UIImage(named: "back"), for: .normal)
    backbutton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
	backbutton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    backbutton.addTarget(self, action: #selector(RootOfferDetailsViewController.backView), for: .touchUpInside)
    let backbarbutton = UIBarButtonItem(customView: backbutton)
    
    favorite = UIButton(type: .custom)
    
   /* if company.favourite! {
      isSelected = true
      favorite.setImage(UIImage(named: "favorite_selected"), for: .normal)
    }else {
      isSelected = false
      favorite.setImage(UIImage(named: "favorite_unselected"), for: .normal)
    }*/
    
    favorite.frame = CGRect(x: 0, y: 0, width: 32, height: 31)
	favorite.titleEdgeInsets = UIEdgeInsets(top: 0, left: -35, bottom: 0, right: 35);
    favorite.addTarget(self, action: #selector(RootOfferDetailsViewController.makeFavourite), for: .touchUpInside)
    let favoritebarbutton = UIBarButtonItem(customView: favorite)
    
    self.navigationItem.setRightBarButton(favoritebarbutton, animated: true)
    self.navigationItem.setLeftBarButton(backbarbutton, animated: true)
  }
  
	@objc func backView() {
    print("back button pressed")
    let _ = self.navigationController?.popViewController(animated: true)
  }
  
	@objc func makeFavourite() {
    if User.getUserID() == "1"{
      Bootstrapper.reset()
      Bootstrapper.showLogin()
      return
    }
    if isSelected {
      
      Utilities.showLoader(controller: self)
      
      let dict: NSDictionary = ["user_ID":User.getUserID(),"sp_ID": company.array_location[0].sp_ID!]
      ServiceWrapper.userFavRemove(requestObject: dict as NSDictionary) {
        (success, response) in
        print("response = %@", response);
        if success{
          self.favorite.setImage(UIImage(named: "favorite_unselected"), for: .normal)
          self.isSelected = false
          
        }else{
          print("Failed")
        }
      }
      
    }else {
      
      let dict: NSDictionary = ["user_ID":User.getUserID(),"sp_ID": company.array_location[0].sp_ID!]
      
      Utilities.showLoader(controller: self)
      
      ServiceWrapper.userFavAdd(requestObject: dict as NSDictionary) {
        (success, response) in
        print("response = %@", response);
        // showAlert(message: response)
        if success{
          self.favorite.setImage(UIImage(named: "favorite_selected"), for: .normal)
          self.isSelected = true
        }else{
          print("Failed")
        }
      }
      
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func didPressOffer(_ sender: UIButton) {
    view_offer.backgroundColor = UIColor.init(hex: "FBEA7E")
    view_details.backgroundColor = UIColor.white
    button_offer.setTitleColor(UIColor.black, for: .normal)
    button_details.setTitleColor(UIColor.gray, for: .normal)
    
    container_offer.isHidden = false
    container_details.isHidden = true
    
    button_details.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
    button_offer.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)
  }
  
  @IBAction func didPressDetails(_ sender: UIButton) {
    
    view_offer.backgroundColor = UIColor.white
    view_details.backgroundColor = UIColor.init(hex: "FBEA7E")
    button_offer.setTitleColor(UIColor.gray, for: .normal)
    button_details.setTitleColor(UIColor.black, for: .normal)
    
    container_offer.isHidden = true
    container_details.isHidden = false
    
    button_offer.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
    button_details.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    if segue.identifier == "sw_offer" {
      print("This is the sw_detailmap")
      nextSceneOffer = segue.destination as! OfferViewController
      nextSceneOffer.company = self.company
      nextSceneOffer.delegate=self
      nextSceneOffer.location = self.company.array_location[0]
    }else if segue.identifier == "sw_details" {
      nextSceneDetails = segue.destination as! DetailsViewController
      nextSceneDetails.company = self.company
      nextSceneDetails.location = self.company.array_location[0]
    }
  }
  
  
  
  func reloadView(sp_id: String, user_id: String) {
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.getCompanyDetail(sp_id: sp_id, user_id: user_id) {
      (success,response) in
      if success{
        
        print(response)
        
        var local_company: CompanyDetail = CompanyDetail()
        local_company.setDataFromServer(response)
        
        self.company = local_company
        
        self.nextSceneOffer.company = self.company
        self.nextSceneOffer.delegate=self
        self.nextSceneOffer.location = self.company.array_location[0]
        self.nextSceneOffer.tableview_offer.reloadData()

        self.nextSceneDetails.company = self.company
        self.nextSceneDetails.location = self.company.array_location[0]
        
      }
    }
  }
  
  //Create method for redeme
  func getRedeem(pin: String, vc_ID: String, userID: String, sp_ID: String, savings: String) -> Void {
    
    let dict: NSDictionary = ["pin":pin, "vc_ID" : vc_ID,"user_ID":userID,"sp_ID": sp_ID,"savings":savings]
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.getRedeem(requestObject: dict as NSDictionary, completionHandler: { (sucess, response) in
      print("response = %@", response);
      if sucess {
        if response.value(forKey: "status") as! String == "successful" {
          let ref_code  = response.value(forKey: "ref_code") as! String
          print("Ref \(ref_code)")
          self.nextSceneOffer.redeemIsSuccessful(ref: ref_code)
        }else {
          let desc = response.value(forKey: "desc") as! String
          self.nextSceneOffer.redeemIsFailed(desc: desc)
        }
      }else {
        let desc = response.value(forKey: "desc") as! String
       // self.nextSceneOffer.redeemIsFailed(desc: desc)
		self.nextSceneOffer.redeemGetsFailed(desc: desc)

        
      }
    })
  }  
}
