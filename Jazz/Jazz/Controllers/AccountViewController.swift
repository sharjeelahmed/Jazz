//
//  AccountViewController.swift
//  Voucher365
//
//  Created by Veer Suthar on 3/12/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
  
  var array_section = ["Instructions", "My Profile", "Membership Number", "Reset Pin","Redemption History","Help and Live chat","Rules of Use", "Logout"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    setupNavigation() 
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if User.getUserID() ==  "1"{
      
      // perhaps use action.title here
      Bootstrapper.reset()
      Bootstrapper.showLogin()
      
      return
      
    }
    
  }
  
  func setupNavigation() {
    
    self.navigationItem.title = "Profile"
    self.navigationController?.navigationBar.barTintColor = UIColor.white
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    
    self.tabBarController?.tabBar.barTintColor = UIColor.white
    self.tabBarController?.tabBar.isTranslucent = false
    self.tabBarController?.tabBar.backgroundImage = UIImage()
    self.tabBarController?.tabBar.shadowImage = UIImage()
    
	self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 13)!]
    
  /*  let backbutton = UIButton(type: .custom)
    backbutton.setImage(UIImage(named: "back"), for: .normal)
    backbutton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    backbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    backbutton.addTarget(self, action: #selector(AccountViewController.backView), for: .touchUpInside)
    let backbarbutton = UIBarButtonItem(customView: backbutton)
    self.navigationItem.setLeftBarButton(backbarbutton, animated: true)*/
  }
  
 @objc func backView() {
    print("back button pressed")
    let _ = self.navigationController?.popViewController(animated: true)
  }
  
  func logout() {
    
    let optionMenu = UIAlertController(title: nil, message: "Are you sure you want to Sign Out?", preferredStyle: .actionSheet)
    let logout = UIAlertAction(title: "Sign Out", style: .destructive, handler: {
      (alert: UIAlertAction!) -> Void in
      
      Utilities.showLoader(controller: self)
      
      let dict: NSDictionary = ["user_ID":User.getUserID(),"sessionID": User.getUserSessionID()]
      
      ServiceWrapper.logOut(requestObject: dict as NSDictionary) {
        (success, response) in
        print("response = %@", response);
        if success{
          print("Sign Out")
          Bootstrapper.reset()
          //          Bootstrapper.showLogin()
        }else{
          print("Failed")
        }
      }
    })
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
      (alert: UIAlertAction!) -> Void in
      print("Cancel")
    })
    optionMenu.addAction(logout)
    optionMenu.addAction(cancel)
    self.present(optionMenu, animated: true, completion: nil)
  }
  
  
  func showAlert (message: String) {
    
    let alertController = UIAlertController(title: "Vouch365", message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
    self.present(alertController, animated: true, completion: nil)
    
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

// MARK: - UITableViewDataSource
extension AccountViewController : UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if User.getUserID() == "1"{
      return 0
    }
    return array_section.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath) as! AccountTableViewCell
    cell.label_title?.text = array_section[indexPath.row]
    return cell
  }
}

// MARK: - UITableViewDelegate
extension AccountViewController: UITableViewDelegate {
  // table view data source methods
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
    
    if indexPath.row == 0{
      
      //INSTRUCTIONS
      let storyBoard = UIStoryboard.init(name: "Login", bundle: nil)
      let createController = storyBoard.instantiateViewController(withIdentifier: "NavTutorialViewController") as!  UINavigationController
      createController.title = "Instructions"
      self.present(createController, animated: true, completion: nil)
      
    }else if indexPath.row == 1{
      //My Information
      let storyBoard = UIStoryboard.init(name: "Account", bundle: nil)
      let informationController = storyBoard.instantiateViewController(withIdentifier: "MyInformationViewController") as!  UINavigationController
      self.present(informationController, animated:true, completion: nil)
    }else if indexPath.row == 2{
      //VIP KEY
      
        let alertController = UIAlertController(title: "Membership Number", message: "Please enter membership number", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "SUBMIT", style: .default, handler: {
        alert -> Void in
        let textField = alertController.textFields![0] as UITextField
        print("VIP Key \(textField.text!)")
        // do something with textField
        
        let dict: NSDictionary = ["user_ID":User.getUserID(),"VIP_key": textField.text!]
        
        Utilities.showLoader(controller: self)
        
        ServiceWrapper.userPremiumRegister(requestObject: dict as NSDictionary) {
          (success, response) in
          print("response = %@", response);
          if success{
            print("Sign Out")
            self.showAlert(message: response ["desc"] as! String)
            
          }else{
            print("Failed")
            self.showAlert(message: response ["desc"] as! String)
          }
        }
        
        
      }))
      alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
      
      alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
        textField.placeholder = "Vip key"
      })
      
      self.present(alertController, animated: true, completion: nil)
      
    }else if indexPath.row == 3{
      //Create PIN
      
      let storyBoard = UIStoryboard.init(name: "Login", bundle: nil)
      let createController = storyBoard.instantiateViewController(withIdentifier: "PinViewViewController") as!  PinViewViewController
      createController.isFromPreferennces = true
      self.present(createController, animated:true, completion: nil)
      
      //      let storyBoard = UIStoryboard.init(name: "Account", bundle: nil)
      //      let createController = storyBoard.instantiateViewController(withIdentifier: "CreatPinViewController") as!  UINavigationController
      //      self.present(createController, animated:true, completion: nil)
      
    }else if indexPath.row == 4{
      //HISTORY REDEEM/PURCHASE
      let storyBoard = UIStoryboard.init(name: "Account", bundle: nil)
      let createController = storyBoard.instantiateViewController(withIdentifier: "PurchaseHistoryViewController") as!  PurchaseHistoryViewController
      createController.title = "Hotel Rules of Use"
        createController.hidesBottomBarWhenPushed = true

      self.navigationController?.pushViewController(createController, animated: true)
      
    }else if indexPath.row == 5{
      //
      
      let storyBoard = UIStoryboard.init(name: "Account", bundle: nil)
      let navigationController = storyBoard.instantiateViewController(withIdentifier: "BrowserViewController") as!  UINavigationController
      let controller = navigationController.viewControllers.first as! BrowserViewController
      controller.url = "https://vouch365.com/contact/meezan.html"
      navigationController.viewControllers.first?.title = "Help and Live Chat"
      self.present(navigationController, animated:true, completion: nil)
      
    }else if indexPath.row == 6{
      //RULES OF USE
      let storyBoard = UIStoryboard.init(name: "Account", bundle: nil)
      let navigationController = storyBoard.instantiateViewController(withIdentifier: "BrowserViewController") as!  UINavigationController
      let controller = navigationController.viewControllers.first as! BrowserViewController
      controller.url = "https://vouch365.com/rules-of-use/index.html"
      navigationController.viewControllers.first?.title = "Rules of Use"
      self.present(navigationController, animated:true, completion: nil)
      
    }else if indexPath.row == 7{
      //LOGOUT
      logout()
    }
  }
}
