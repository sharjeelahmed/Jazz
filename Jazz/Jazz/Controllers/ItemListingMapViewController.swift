//
//  ItemListingMapViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/19/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

import GooglePlaces
import GoogleMaps
import CoreLocation
import MapKit


class ItemListingMapViewController: UIViewController , CLLocationManagerDelegate ,GMSMapViewDelegate {
  
  var titleOfView = ""
  
  @IBOutlet weak var view_list: UIView!
  @IBOutlet weak var view_map: UIView!
  
  var array_list : Array<Category> = Array<Category>()
  @IBOutlet weak var tableview_category: UITableView!
  
  var lat = Double()
  var lon = Double()
  var zoomValue = Float()
  var arrayOfDistance = [String]()
  var mapView = GMSMapView()
  var locationManager: CLLocationManager!
  var userSelectedMarker = GMSMarker()
  let startMarker = GMSMarker()
  
  var company: CompanyDetail = CompanyDetail()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    print("Viewss are \(titleOfView)")
	setupView()
    zoomValue = 15
    print(  "Lat \nLong ",lat,lon)
    
    lat = 24.861462
    lon = 67.064331
    
    let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 15)
    mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), camera: camera)
    
    mapView.camera = camera
    
    mapView.isMyLocationEnabled = true
    mapView.settings.compassButton = true
    mapView.settings.myLocationButton = true
    view_map.addSubview(mapView)
    
    mapView.delegate = self
    
    locationManager = CLLocationManager()
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()
    
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.startUpdatingLocation()
    }
    
    if let mylocation = mapView.myLocation {
      print("loc: \(mylocation)")
    } else {
      print("User's location is unknown")
    }
    
    // let current_location = CLLocation(latitude: lat, longitude: lon)
    var array: Array <CLLocation> = Array()
    
    for i in 0 ..< array_list.count  {
      
      let voucher = array_list[i] as! Category
      
      let lat = voucher.latitude!.trimmingCharacters(in: .whitespacesAndNewlines)
      let long = voucher.longitude!.trimmingCharacters(in: .whitespacesAndNewlines)
      let coordinate = CLLocation(latitude: Double(lat)!, longitude: Double(long)!)
      // let distanceInMeters = current_location.distance(from: coordinate) // result is in meters
      
      let startMarker = GMSMarker()
      startMarker.position = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
      startMarker.appearAnimation = .pop
      startMarker.title = voucher.name
      startMarker.snippet = voucher.locality
      startMarker.map = mapView
      
      array.append(coordinate)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func findDistance(){
    arrayOfDistance.removeAll()
    for i in 0 ..< array_list.count  {
      let voucher = array_list[i] as! Category
      let coordinate = CLLocation(latitude:Double(voucher.latitude!)!, longitude: Double(voucher.longitude!)!)
      let userLocation = CLLocation(latitude:Double(lat), longitude: Double(lon))
      let distanceInMeters = coordinate.distance(from: userLocation) * 0.000621371 // result is in meters
		
      arrayOfDistance.append("\(round(10*distanceInMeters)/10)")
      print("Distance in kilometer:  \(round(10*distanceInMeters)/10)")
      print("Distance in kilometer:  \(distanceInMeters)")
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
      self.tableview_category.reloadData()
      
    }
    
    
  }
  
  func setupView() {
    
    view_list.isHidden = false
    findDistance()
    view_map.isHidden = true
    
  }
  
  
  func showMap() {
    view_list.isHidden = true
    view_map.isHidden = false
    //    array_list
    mapView.clear()
    print(array_list)
    
    for i in 0 ..< array_list.count  {
      
      let voucher = array_list[i] as! Category
      
      print("Lat is  \(voucher.latitude!)")
      print("Long is \(voucher.longitude!)")
      
      let coordinate = CLLocation(latitude:Double(voucher.latitude!)!, longitude: Double(voucher.longitude!)!)
      let userLocation = CLLocation(latitude:Double(lat), longitude: Double(lon))
      let distanceInMeters = coordinate.distance(from: userLocation) * 0.000621371 // result is in meters
      print("Distance in kilometer:  \(round(10*distanceInMeters)/10)")
      print("Distance in kilometer:  \(distanceInMeters)")
      
    
      startMarker.position = CLLocationCoordinate2D(latitude: Double(voucher.latitude!)!, longitude: Double(voucher.longitude!)!)
      
      startMarker.appearAnimation = .pop
      startMarker.title = voucher.name
      startMarker.snippet = voucher.locality
      startMarker.map = mapView
        startMarker.userData = voucher.sp_ID

      
    }
    
    
    // let current_location = CLLocation(latitude: lat, longitude: lon)
    var array: Array <CLLocation> = Array()
    
    for i in 0 ..< array_list.count  {
      
      let voucher = array_list[i] as! Category
      
      let lat = voucher.latitude!.trimmingCharacters(in: .whitespacesAndNewlines)
      let long = voucher.longitude!.trimmingCharacters(in: .whitespacesAndNewlines)
      let coordinate = CLLocation(latitude: Double(lat)!, longitude: Double(long)!)
      
      print("Coordinates",coordinate)
      
      // let distanceInMeters = current_location.distance(from: coordinate) // result is in meters
      
      let startMarker = GMSMarker()
      startMarker.position = CLLocationCoordinate2D(latitude: Double(lat)!, longitude: Double(long)!)
      
      startMarker.appearAnimation = .pop
      startMarker.title = voucher.name
      startMarker.snippet = voucher.locality
      startMarker.map = mapView
      startMarker.userData = voucher.sp_ID
      array.append(coordinate)
    }
  }
  
  func showList() {
    findDistance()
    view_list.isHidden = false
    view_map.isHidden = true
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations.last! as CLLocation
    
    
    locationManager.stopUpdatingLocation()
    
    
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .restricted:
      print("Location access was restricted.")
    case .denied:
      print("User denied access to location.")
      // Display the map using the default location.
      mapView.isHidden = false
    case .notDetermined:
      print("Location status not determined.")
    case .authorizedAlways: fallthrough
    case .authorizedWhenInUse:
      print("Location status is OK.")
    }
  }
  
  
  private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    if status == CLAuthorizationStatus.authorizedWhenInUse {
      mapView.isMyLocationEnabled = true
    }
  }
  
  
  func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
//    userSelectedMarker.position = coordinate
//    userSelectedMarker.appearAnimation = .pop
//    userSelectedMarker.title = "Address"
//    userSelectedMarker.snippet = "selected"
//    userSelectedMarker.map = mapView
  }
  
  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//    userSelectedMarker.position = coordinate
//    userSelectedMarker.appearAnimation = .pop
//    userSelectedMarker.title = "Address"
//    userSelectedMarker.snippet = "selected"
//    userSelectedMarker.map = mapView
  }

    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
		print("Home is  \((marker.userData as! String?)!)")
		self.fetchCompanyDetail(sp_id: (marker.userData as! String?)!, user_id: User.getUserID())
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

extension ItemListingMapViewController : UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let category : Category = array_list[indexPath.row] as! Category
    
    fetchCompanyDetail(sp_id: category.sp_ID,user_id: User.getUserID())
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 275
  }
}

extension ItemListingMapViewController : UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array_list.count
  }
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
		let category : Category = array_list[indexPath.row]
		cell.label_title.text = category.name
		let url = URL(string: "\(category.header!)")
		cell.imageview_logo.kf.setImage(with: url)
		cell.label_voucherName.text = category.discount
		return cell

	}
  
}
