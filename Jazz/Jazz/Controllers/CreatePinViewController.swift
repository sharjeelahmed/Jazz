//
//  CreatePinViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/15/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class CreatPinViewController: UIViewController, APPinViewDelegate {
  
  @IBOutlet weak var pinView: APPinView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    setupNavigation()
    pinView.delegate = self
    pinView.becomeFirstResponder()
    
   // IQKeyboardManager.sharedManager().disabledToolbarClasses = [PinViewViewController.self]
    IQKeyboardManager.shared.disabledToolbarClasses = [PingsViewController.self]
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setupNavigation() {
    
    self.navigationItem.title = "Create PIN"
    
    self.navigationController?.navigationBar.barTintColor = UIColor.white
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    
    
    self.tabBarController?.tabBar.barTintColor = UIColor.white
    self.tabBarController?.tabBar.isTranslucent = false
    self.tabBarController?.tabBar.backgroundImage = UIImage()
    self.tabBarController?.tabBar.shadowImage = UIImage()

	self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 13)!]
    
    let logout = UIButton(type: .custom)
    logout.setImage(UIImage(named: "cross"), for: .normal)
    logout.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    logout.addTarget(self, action: #selector(BrowserViewController.backView), for: .touchUpInside)
    let logoutbarbutton = UIBarButtonItem(customView: logout)
    self.navigationItem.setRightBarButton(logoutbarbutton, animated: true)
    self.navigationItem.hidesBackButton = true
  }
  
  func backView() {
    pinView.endEditing(true)
    dismiss(animated: true, completion: nil)
  }
  
  //  The converted code is limited by 2 KB.
  //  Upgrade your plan to remove this limitation.
  func pinCodeView(_ view: APPinView, didEnterPin pinCode: String) {
    //Compare or Create PIN here.
    print("PING CODE \(pinCode)")
    self.dismiss(animated: true, completion: nil)
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
