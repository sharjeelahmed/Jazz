//
//  RootViewController.swift
//  Voucher365
//
//  Created by Veer Suthar on 3/4/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
  
  var selectedButtonIndex: Int = 0
  
  @IBOutlet weak var button_login: UIButton!
  @IBOutlet weak var button_register: UIButton!
  
  @IBOutlet weak var container_login: UIView!
  @IBOutlet weak var container_register: UIView!
  
  @IBOutlet weak var view_signin: UIView!
  @IBOutlet weak var view_register: UIView!
  
  //sdk commit
  //var nextSceneLogin = HomeViewController()
  //sdk
  var nextSceneLogin = HomeViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    button_login.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
    button_register.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
    
    if selectedButtonIndex == 0 {
      view_signin.backgroundColor = UIColor.red
      view_register.backgroundColor = UIColor.white
      container_login.isHidden = false
      container_register.isHidden = true
      button_login.setTitleColor(UIColor.black, for: .normal)
      button_register.setTitleColor(UIColor.gray, for: .normal)
      
      button_login.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)
      button_register.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
      
      
    }else {
      view_signin.backgroundColor = UIColor.white
      view_register.backgroundColor = UIColor.red
      container_login.isHidden = true
      container_register.isHidden = false
      button_login.setTitleColor(UIColor.gray, for: .normal)
      button_register.setTitleColor(UIColor.black, for: .normal)
      
      button_register.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)
      button_login.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
      
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    //sdk commit
   /* if segue.identifier == "sw_login" {
      nextSceneLogin = segue.destination as! ho
      nextSceneLogin.delegate = self
    }*/
    //sdk work
	if segue.identifier == "sw_login" {
		 nextSceneLogin = segue.destination as! HomeViewController
		// nextSceneLogin.delegate = self
	   }
  }
  
  @IBAction func backButtonPressed(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  func DisplayRegisterView() {
    
    view_signin.backgroundColor = UIColor.white
    view_register.backgroundColor = UIColor.red
    button_login.setTitleColor(UIColor.gray, for: .normal)
    button_register.setTitleColor(UIColor.black, for: .normal)
    
    container_login.isHidden = true
    container_register.isHidden = false
    
    button_register.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)
    button_login.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
    
  }
  
  
  
  @IBAction func loginButtonPressed(_ sender: UIButton) {
    view_signin.backgroundColor = UIColor.red
    view_register.backgroundColor = UIColor.white
    button_login.setTitleColor(UIColor.black, for: .normal)
    button_register.setTitleColor(UIColor.gray, for: .normal)
    
    container_login.isHidden = false
    container_register.isHidden = true
    
    button_login.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)
    button_register.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
  }
  
  @IBAction func registerButtonPressed(_ sender: UIButton) {
    view_signin.backgroundColor = UIColor.white
    view_register.backgroundColor = UIColor.red
    button_login.setTitleColor(UIColor.gray, for: .normal)
    button_register.setTitleColor(UIColor.black, for: .normal)
    
    container_login.isHidden = true
    container_register.isHidden = false
    
    button_register.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)
    button_login.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
  }
}

extension UIView {
  
  @IBInspectable var shadow: Bool {
    get {
      return layer.shadowOpacity > 0.0
    }
    set {
      if newValue == true {
        self.addShadow()
      }
    }
  }
  
  @IBInspectable var cornerRadius: CGFloat {
    get {
      return self.layer.cornerRadius
    }
    set {
      self.layer.cornerRadius = newValue
      
      // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
      if shadow == false {
        self.layer.masksToBounds = true
      }
    }
  }
  
  
  @IBInspectable var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable var borderColor: UIColor? {
    get {
      return UIColor(cgColor: layer.borderColor!)
    }
    set {
      layer.borderColor = newValue?.cgColor
    }
  }
  
  
  
  func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                 shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                 shadowOpacity: Float = 0.4,
                 shadowRadius: CGFloat = 3.0) {
    layer.shadowColor = shadowColor
    layer.shadowOffset = shadowOffset
    layer.shadowOpacity = shadowOpacity
    layer.shadowRadius = shadowRadius
  }
}
