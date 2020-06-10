//
//  LocationsViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/25/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class LocationsViewController: UIViewController {
  
  @IBOutlet weak var label_outletcount: UILabel!
  weak var delegate: RootOfferDetailsViewController?
  
  var array_outlets: Array <Location> = Array()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    setupNavigation()
    label_outletcount.text = "\(array_outlets.count) Outlets"
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
  
  
  func setupNavigation() {
    
    self.navigationItem.title = "Outlets"
    
    self.navigationController?.navigationBar.barTintColor = UIColor.init(hex: "#464748")
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    
    
    self.tabBarController?.tabBar.barTintColor = UIColor.white
    self.tabBarController?.tabBar.isTranslucent = false
    self.tabBarController?.tabBar.backgroundImage = UIImage()
    self.tabBarController?.tabBar.shadowImage = UIImage()
    
	self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 13)!]
    
    let done = UIButton(type: .custom)
    done.setTitle("Cancel", for: .normal)
    done.setTitleColor(.white, for: .normal)
    done.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 16)
    done.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
	done.titleEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: -35);
    done.addTarget(self, action: #selector(LocationsViewController.done), for: .touchUpInside)
    let updatebarbutton = UIBarButtonItem(customView: done)
    self.navigationItem.setRightBarButton(updatebarbutton, animated: true)
  }
  
	@objc func done(){
    delegate?.pushNewView()
    dismiss(animated: true, completion: nil)
  }
  
  func backView() {
    dismiss(animated: true, completion: nil)
  }
}

extension LocationsViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 55
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delegate?.pushNewView(location: array_outlets[indexPath.row])
    delegate?.pushNewView()
	dismiss(animated: true, completion: nil)
  }
}

extension LocationsViewController : UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array_outlets.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as! LocationTableViewCell
    
    let location = array_outlets [indexPath.row]
    cell.label_title.text = location.locality
    cell.label_description.text = location.locations
	
    
    return cell
  }
}
