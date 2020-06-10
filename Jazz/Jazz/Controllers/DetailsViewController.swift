//
//  DetailsViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/24/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces
import GoogleMaps
import CoreLocation

class DetailsViewController: UIViewController {
  
  @IBOutlet weak var tableview_details: UITableView!
  let lat : Double! =  24.861462
  let lon : Double! = 67.064331
  var company: CompanyDetail = CompanyDetail()
  var location: Location = Location()
  var seeMoreOption : Bool = false
  let newPin = MKPointAnnotation()
  
  var array_available : Array<Dictionary<String, String>> = Array()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    seeMoreOption = false
    // Do any additional setup after loading the view.

    if company.bakery == "1" {
    var dictionary : Dictionary <String, String> = Dictionary()
    dictionary["value"] = "Bakery"
      dictionary["image"] = "Bakery"
    array_available.append(dictionary)
    }

    if company.brunch == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Brunch"
      dictionary["image"] = "Brunch"
      array_available.append(dictionary)
    }

    if company.buffet == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Buffet"
      dictionary["image"] = "Buffet"
      array_available.append(dictionary)
    }

    if company.delivery == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Delivery"
      dictionary["image"] = "Delivery"
      array_available.append(dictionary)
    }

    if company.groups == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Groups Welcome"
      dictionary["image"] = "Groups_Welcome"
      array_available.append(dictionary)
    }

    if company.halal == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Halal"
      dictionary["image"] = "Halal"
      array_available.append(dictionary)
    }

    if company.kids == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Kids Welcome"
      dictionary["image"] = "Kids_Welcome"
      array_available.append(dictionary)
    }

    if company.livee == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Live Entertainment"
      dictionary["image"] = "Live_Entertainment"
      array_available.append(dictionary)
    }

    if company.outc == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Outdoor Cooling"
      dictionary["image"] = "Outdoor_Cooling"
      array_available.append(dictionary)
    }

    if company.outh == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Outdoor Heating"
      dictionary["image"] = "Outdoor_Heating"
      array_available.append(dictionary)
    }

    if company.outs == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Outdoor Sitting"
      dictionary["image"] = "Outdoor_Sitting"
      array_available.append(dictionary)
    }

    if company.parking == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["key"] = company.bakery
      dictionary["value"] = "Parking"
      dictionary["image"] = "Parking"
      array_available.append(dictionary)
    }

    if company.pet == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Pets Allowed"
      dictionary["image"] = "Pets_Allowed"
      array_available.append(dictionary)
    }

    if company.smokein == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Smoking Indoor"
      dictionary["image"] = "Smoking_Indoor"
      array_available.append(dictionary)
    }
    
    if company.smokeout == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Smoking Outdoor"
      dictionary["image"] = "Smoking_Outdoor"
      array_available.append(dictionary)
    }
    if company.smokesh == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Smoking Shisha"
      dictionary["image"] = "Smoking_Shisha"
      array_available.append(dictionary)
    }
    if company.sports == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Sports Screens"
      dictionary["image"] = "Sports_Screens"
      array_available.append(dictionary)
    }
    if company.playarea == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Supervised Play Area"
      dictionary["image"] = "Supervised_Play_Area"
      array_available.append(dictionary)
    }
    if company.takeaway == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Takeaway"
      dictionary["image"] = "Takeaway"
      array_available.append(dictionary)
    }
    if company.valet == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Valet Parking"
      dictionary["image"] = "Valet_Parking"
      array_available.append(dictionary)
    }
    if company.wheelch == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Wheelchair Accessible"
      dictionary["image"] = "Wheelchair_Accessible"
      array_available.append(dictionary)
    }
    if company.wifi == "1" {
      var dictionary : Dictionary <String, String> = Dictionary()
      dictionary["value"] = "Wi-Fi"
      dictionary["image"] = "Wi_Fi"
      array_available.append(dictionary)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  
  func reloadTable() {
    if self.tableview_details != nil {
      self.tableview_details.reloadData()
    }
  }
}


extension DetailsViewController : UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    switch indexPath.row {
    case 0:
      return 80
    case 1:
      if !seeMoreOption {
        return 64
      }
	return UITableView.automaticDimension
    //return 64
    case 2:
      return 156
    case 3:
      return 38
    case 4:
      return 40
    default:
      return 40
    }
    
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
    case 0:
      return 80
    case 1:
      return 64
    case 2:
      return 156
    case 3:
      return 38
    case 4:
      return 40
    default:
      return 40
    }
    
  }
}

extension DetailsViewController : UITableViewDataSource {
  
  //    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
  //    {
  //        return UITableViewAutomaticDimension
  //    }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array_available.count + 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "MainDetailsTableViewCell") as! MainDetailsTableViewCell
      
      cell.label_name.text = location.city?.uppercased()
      cell.label_type.text = self.location.locations
      let userLocation = CLLocation(latitude:Double(lat), longitude: Double(lon))
      
      //  cell.label_distance.text = Utilities.getDistanceInKM(lat: Double(location.latitude!)!, lon: Double(location.longitude!)!, userLocation: userLocation)
      
      
      cell.label_distance.text = Utilities.getDistanceInKM(lat1: Double(location.latitude!)!, lon1: Double(location.longitude!)!, lat2: userLocation.coordinate.latitude, lon2: userLocation.coordinate.longitude, unit: "K")
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyDescriptionTableViewCell") as! CompanyDescriptionTableViewCell
      cell.label_description.text = company.desc
	cell.seeMoreBtn.addTarget(self, action: #selector(DetailsViewController.seeMorePressed(_:)), for: UIControl.Event.touchUpInside)
      return cell
    case 2:
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell_map") as! DetailMapTableViewCell
      if let lon = Double(self.location.latitude!) {
        print("Location \(lon)")
      }
      var mapView = GMSMapView()
      let startMarker = GMSMarker()
      
      let camera = GMSCameraPosition.camera(withLatitude: Double(self.location.latitude!)!, longitude: Double(self.location.longitude!)!, zoom: 20)
      mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: cell.frame.size.height), camera: camera)
	
      mapView.camera = camera
      
      mapView.isMyLocationEnabled = true
      mapView.settings.compassButton = true
      mapView.settings.myLocationButton = true
	cell.contentView.addSubview(mapView)
      startMarker.position = CLLocationCoordinate2D(latitude: Double(self.location.latitude!)!, longitude: Double(self.location.longitude!)!)
      
      startMarker.appearAnimation = .pop
      startMarker.title = self.company.name
      startMarker.snippet = self.location.locality
      startMarker.map = mapView
	
	
      
      return cell
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: "OfferDetailsTableViewCell") as! OfferDetailsTableViewCell

      let index = indexPath.row - 3
      let dictionary = array_available [index]
      
      if let imagename = dictionary["image"] {
        cell.imageview_available.image = UIImage(named: imagename)
      }
      
      if let value = dictionary["value"]{
        cell.label_available.text = value
      }
      
      return cell
    }
  }
  
	@objc func seeMorePressed(_ button: UIButton) {
    print("Nothing")
    if seeMoreOption {
      seeMoreOption = false
      button.setTitle("Show more", for: .normal)
    }
    else {
      seeMoreOption = true
      button.setTitle("Show less", for: .normal)
    }
    self.reloadTable()
  }
}


extension DetailsViewController : UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 15
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as! DetailsCollectionViewCell
    return cell
  }
}

extension DetailsViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("INdex Path in collectionView \(indexPath.row)")
  }
}
extension String {
  func toDouble(_ locale: Locale) -> Double {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.locale = locale
    formatter.usesGroupingSeparator = true
    if let result = formatter.number(from: self)?.doubleValue {
      return result
    } else {
      return 0
    }
  }
}

