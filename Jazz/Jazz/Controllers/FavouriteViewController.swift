//
//  FavouriteViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/20/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit
import MapKit

class FavouriteViewController: UIViewController {
  
  @IBOutlet weak var tableFavorite: UITableView!
  var array_favourites: Array<Offer> = Array()
  var company: CompanyDetail = CompanyDetail()
  let lat : Double! =  24.861462
  let lon : Double! = 67.064331
  
  @IBOutlet weak var viewNoFav: UIView!{
    didSet{
      viewNoFav.isHidden = true
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
	
    if User.getUserID() ==  "1"{
      Bootstrapper.reset()
      Bootstrapper.showLogin()
      
      return
      
    }
    getFavorite()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func getFavorite(){
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.getUserFav(user_id: User.getUserID()) {
      (success,response) in
      if success{
        let array = response.value(forKey: "data") as! NSArray
        
        self.array_favourites.removeAll()
        print("Final Favourite is \(array)")
        
        var offer = Offer()
        if ((array.count) > 0) {
          for index in 0...(array.count)-1 {
            offer = Offer()
            offer.setDataFromServer(dict: (array.object(at: index) as? NSDictionary)!)
            self.array_favourites.append(offer)
          }
          self.tableFavorite.reloadData()
        }
      }
    }
  }
  
  
  
  func fetchCompanyDetail(sp_id: String, user_id: String) {
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.getCompanyDetail(sp_id: sp_id, user_id: user_id) {
      (success,response) in
      if success{
        print(response)
        
        var local_company: CompanyDetail = CompanyDetail()
        local_company.setDataFromServer(response)
        
        self.company = local_company
        
        let viewController:RootOfferDetailsViewController = UIStoryboard(name: "Main-Pso", bundle: nil).instantiateViewController(withIdentifier: "RootOfferDetailsViewController") as! RootOfferDetailsViewController
        viewController.company = self.company
        
        viewController.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(viewController, animated: true)
      }
    }
  }
  
}

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource{
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array_favourites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell") as! FavouriteTableViewCell
    let offer : Offer = array_favourites[indexPath.row]
    
    cell.label_name.text = offer.name!
    let userLocation = CLLocation(latitude:Double(lat), longitude: Double(lon))
    
    //cell.label_distance.text =
    
//    cell.label_distance.text = "\(String(describing: offer.locality!)) - \(Utilities.getDistanceInKM(lat: Double(offer.latitude!)!, lon: Double(offer.longitude!)!, userLocation: userLocation))"

    cell.label_distance.text = Utilities.getDistanceInKM(lat1: Double(offer.latitude!)!, lon1: Double(offer.longitude!)!, lat2: userLocation.coordinate.latitude, lon2: userLocation.coordinate.longitude, unit: "K")
 cell.label_distance.text = " \(offer.locality ?? "") - " +  cell.label_distance.text!
    
    let url = URL(string: offer.logo!)
    cell.imageview_logo.kf.setImage(with: url)
    
    
    if offer.category == "restaurant" {
      cell.imageview_icon.image = UIImage(named:"icon_food")
    }
    else if offer.category == "kids" {
      cell.imageview_icon.image = UIImage(named:"icon_health")
    }
    else if offer.category == "leisure" {
      cell.imageview_icon.image = UIImage(named:"icon_leisure")
    }
    else if offer.category == "body" {
      cell.imageview_icon.image = UIImage(named:"icon_saloon")
    }
    else if offer.category == "services" {
      cell.imageview_icon.image = UIImage(named:"icon_service")
    }
    else if offer.category == "travel" {
      cell.imageview_icon.image = UIImage(named:"icon_travel")
    }
    
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 72
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    print(array_favourites[indexPath.row])
    
    let category : Offer = array_favourites[indexPath.row] as! Offer
    fetchCompanyDetail(sp_id: category.sp_ID!,user_id: User.getUserID())
    
  }
}

