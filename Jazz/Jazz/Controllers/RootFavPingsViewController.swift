//
//  RootFavPingsViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/20/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class RootFavPingsViewController: UIViewController {
  
  @IBOutlet weak var container_favourite: UIView!
  @IBOutlet weak var container_pings: UIView!
  
  @IBOutlet weak var button_fav: UIButton!
  @IBOutlet weak var button_pings: UIButton!
  
  @IBOutlet weak var view_fav: UIView!
  @IBOutlet weak var view_pings: UIView!
  
  var selectedButtonIndex: Int = 0
  
  @IBOutlet weak var label_title: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    setupNavigation()
    self.navigationItem.title = "Favourites"

    button_fav.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
  //  button_pings.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
    
    if selectedButtonIndex == 0 {
      
     // self.navigationItem.title = "Favourites"
      view_fav.backgroundColor = UIColor.red
    //  view_pings.backgroundColor = UIColor.white
      container_favourite.isHidden = false
      //container_pings.isHidden = true
      button_fav.setTitleColor(UIColor.black, for: .normal)
      //button_pings.setTitleColor(UIColor.gray, for: .normal)
      button_fav.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)
     // button_pings.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
    }else {
      self.navigationItem.title = "Pings"
      view_fav.backgroundColor = UIColor.white
      view_pings.backgroundColor = UIColor.red
      container_favourite.isHidden = true
      container_pings.isHidden = false
      button_fav.setTitleColor(UIColor.gray, for: .normal)
      button_pings.setTitleColor(UIColor.black, for: .normal)
      button_pings.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)
      button_fav.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
    }
  }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
  func setupNavigation() {
    
    self.navigationItem.title = "Favourites"
    
    self.navigationController?.navigationBar.barTintColor = UIColor.white
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    
    
    self.tabBarController?.tabBar.barTintColor = UIColor.white
    self.tabBarController?.tabBar.isTranslucent = false
    self.tabBarController?.tabBar.backgroundImage = UIImage()
    self.tabBarController?.tabBar.shadowImage = UIImage()
    
    // self.view.backgroundColor = UIColor.init(hex: "#f0f0f0")
    
	self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 13)!]
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func didPressFavourite(_ sender: UIButton) {
    
    self.navigationItem.title = "Favourites"
    
    view_fav.backgroundColor = UIColor.red
    view_pings.backgroundColor = UIColor.white
    button_fav.setTitleColor(UIColor.black, for: .normal)
    button_pings.setTitleColor(UIColor.gray, for: .normal)
    
    container_favourite.isHidden = false
    container_pings.isHidden = true
    
    button_pings.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
    button_fav.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)
    
  }
  
  @IBAction func didPressPings(_ sender: UIButton) {
    
    self.navigationItem.title = "Pings"
    
    view_fav.backgroundColor = UIColor.white
 //   view_pings.backgroundColor = UIColor.red
    button_fav.setTitleColor(UIColor.gray, for: .normal)
 //   button_pings.setTitleColor(UIColor.black, for: .normal)
    
    container_favourite.isHidden = true
   // container_pings.isHidden = false
    
    button_fav.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
    //button_pings.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)
    
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
