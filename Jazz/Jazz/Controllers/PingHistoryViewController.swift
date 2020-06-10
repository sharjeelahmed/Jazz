//
//  PingHistoryViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/16/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class PingHistoryViewController: UIViewController {

  @IBOutlet weak var container_received: UIView!
  @IBOutlet weak var container_sent: UIView!
  
  @IBOutlet weak var button_received: UIButton!
  @IBOutlet weak var button_sent: UIButton!
  
  @IBOutlet weak var view_received: UIView!
  @IBOutlet weak var view_sent: UIView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
      setupNavigation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  func setupNavigation() {
    
    self.navigationItem.title = "Ping History"
    
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
  
  func backView() {
    print("back button pressed")
    let _ = self.navigationController?.popViewController(animated: true)
  }
  
    @IBAction func didPressReceivedPings(_ sender: Any) {
        
        view_received.backgroundColor = UIColor.red
        view_sent.backgroundColor = UIColor.white
        button_received.setTitleColor(UIColor.black, for: .normal)
        button_sent.setTitleColor(UIColor.gray, for: .normal)
        
        container_received.isHidden = false
        container_sent.isHidden = true
        
        button_sent.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
        button_received.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)

    }
    @IBAction func didPressSentPings(_ sender: Any) {
        
        
        view_received.backgroundColor = UIColor.white
        view_sent.backgroundColor = UIColor.red
        button_received.setTitleColor(UIColor.gray, for: .normal)
        button_sent.setTitleColor(UIColor.black, for: .normal)
        
        container_received.isHidden = true
        container_sent.isHidden = false
        
        button_received.titleLabel!.font =  UIFont(name: "Helvetica-Light", size: 13)
        button_sent.titleLabel!.font =  UIFont(name: "Helvetica-Bold", size: 13)
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
