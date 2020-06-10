//
//  PingsViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/20/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class PingsViewController: UIViewController {
  
  var array_pings :Array <Any> = Array()
  
  @IBOutlet weak var tablePing: UITableView!
  
  @IBOutlet weak var viewNoPings: UIView!{
    didSet{
      viewNoPings.isHidden = true
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getPings()
    getPingsList()
  }
  
  func getPings(){
    
    let userDict = ["userID":User.getUserID(),
                    "frID":User.getUserID(),
                    "spID":User.getUserID(),
                    "vcID":"password" ?? " no password"] as [String : Any]
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.vouchPingCall(requestObject: userDict as NSDictionary) {
      (success, response) in
        
      print("response = %@", response);
      if success{
        print("response = %@", response);
        
      }else{
        print("Failed")
      }
    }
  }
    
    func getPingsList(){
        
        let userDict = ["user_ID":User.getUserID()] as [String : Any]
        
        Utilities.showLoader(controller: self)
        
        ServiceWrapper.vouchPingCallList(requestObject: userDict as NSDictionary) {
            (success, response) in
            print("response = %@", response);
            if success{
                print("response = %@", response);
                
                let array = response.value(forKey: "data") as! NSArray
                
                self.array_pings.removeAll()
                
                var ping = Ping()
                if ((array.count) > 0) {
                    for index in 0...(array.count)-1 {
                        ping = Ping()
                        ping.setDataFromServer(dict: (array.object(at: index) as? NSDictionary)!)
                        self.array_pings.append(ping)
                    }
                    self.tablePing.reloadData()
                }
                
            }else{
                print("Failed")
            }
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
  
}

extension PingsViewController: UITableViewDelegate, UITableViewDataSource{
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array_pings.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PingTableViewCell") as! PingTableViewCell
    let ping:Ping  = array_pings[indexPath.row] as! Ping
    cell.label_name.text = ping.name ?? ""
    cell.label_locality.text = ping.locality ?? ""
    cell.label_pingdesc.text = ping.pingdesc ?? ""
    
    
    let url = URL(string: ping.logo!)
    cell.imageview_logo.kf.setImage(with: url)
    
    
    if ping.category == "restaurant" {
        cell.imageview_icon.image = UIImage(named:"icon_food")
    }
    else if ping.category == "kids" {
        cell.imageview_icon.image = UIImage(named:"icon_health")
    }
    else if ping.category == "leisure" {
        cell.imageview_icon.image = UIImage(named:"icon_leisure")
    }
    else if ping.category == "body" {
        cell.imageview_icon.image = UIImage(named:"icon_saloon")
    }
    else if ping.category == "services" {
        cell.imageview_icon.image = UIImage(named:"icon_service")
    }
    else if ping.category == "travel" {
        cell.imageview_icon.image = UIImage(named:"icon_travel")
    }
    
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
}




