//
//  PurchaseHistoryViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/16/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class PurchaseHistoryViewController: UIViewController {
  
  @IBOutlet weak var view_no_history: UIView!
  @IBOutlet weak var tableview_history: UITableView!
  
  var array_history : Array <History> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    setupNavigation()
    
    self.view_no_history.isHidden = true
    self.tableview_history.isHidden = true
    let dict: NSDictionary = ["user_ID":User.getUserID()]
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.redemptionHistory(requestObject: dict as NSDictionary) {
      (success, response) in
      print("response = ", response);
      if success{
        let array_history = response.value(forKey: "data")

        self.array_history = History.getArrayOfHistory(array: array_history as! Array <Dictionary <String, Any>>)
        
        if (self.array_history.count > 0) {
          self.view_no_history.isHidden = true
          self.tableview_history.isHidden = false
          self.tableview_history.reloadData()
        }else {
          self.view_no_history.isHidden = false
          self.tableview_history.isHidden = true
        }
      }else{
        print("Failed")
        self.view_no_history.isHidden = false
        self.tableview_history.isHidden = true
        
      }
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func setupNavigation() {
    
    self.navigationItem.title = "Redemption History"
    
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
    backbutton.addTarget(self, action: #selector(PurchaseHistoryViewController.backView), for: .touchUpInside)
    let backbarbutton = UIBarButtonItem(customView: backbutton)
    
    self.navigationItem.setLeftBarButton(backbarbutton, animated: true)
  }
  
	@objc func backView() {
    print("back button pressed")
    let _ = self.navigationController?.popViewController(animated: true)
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


extension PurchaseHistoryViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
      let history = self.array_history [indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "historyTableViewCell") as! HistoryTableViewCell
    
    cell.label_sp_name.text = history.sp_name!
    cell.label_vc_name.text = history.vc_name!
    cell.label_ref_code.text = "Reference Code: \(history.ref_code!)"
    cell.label_date.text = history.date!
    cell.label_savings.text = "Rs \(history.savings!)"
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 20;
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1 // count of items
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let header = UIView()
    header.backgroundColor = UIColor.clear
    return header
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array_history.count
  }
}


