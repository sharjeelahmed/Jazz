//
//  InviteViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/24/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

//import Bolts

class InviteViewController: UIViewController {
  
  @IBOutlet weak var imageBanner: UIImageView!
  
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var imageIcon: UIImageView!
  
  
  @IBOutlet weak var btnFacebook: UIButton!
  @IBOutlet weak var btnSMS: UIButton!
  
  @IBOutlet weak var btnWhatsApp: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    customizeView()
    
    setupNavigation()
  }
  
  @IBAction func didTapMessenger(_ sender: UIButton) {
//    if UIApplication.shared.canOpenURL(NSURL(string: "fb-messenger-api://")! as URL) {
//      let content = FBSDKShareLinkContent()
//      content.contentURL = NSURL(string: "url") as URL!
////      content.contentTitle = "your awesome title"
//
//      FBSDKMessageDialog.show(with: content, delegate: self)
//    } else {
//      UIApplication.shared.openURL(NSURL(string: "https://itunes.apple.com/pl/app/messenger/id454638411?mt=8")! as URL)
//    }
  }
  
  
  @IBAction func didTapSMS(_ sender: UIButton) {
    let text = "This is some text that I want to share."
    
    // set up activity view controller
    let textToShare = [ text ]
    let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
    
    // exclude some activity types from the list (optional)
	activityViewController.excludedActivityTypes = [UIActivity.ActivityType.message ]
    
    // present the view controller
    self.present(activityViewController, animated: true, completion: nil)
    

  }
  
  
  @IBAction func didTapwhatsApp(_ sender: UIButton) {
    
    let whatsappURL = URL(string: "whatsapp://send?text=Hello%2C%20World!")
    if UIApplication.shared.canOpenURL(whatsappURL!) {
      UIApplication.shared.openURL(whatsappURL!)
    }
    
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func setupNavigation() {
    
    self.navigationItem.title = "Invitation"
    
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
    backbutton.addTarget(self, action: #selector(AccountViewController.backView), for: .touchUpInside)
    let backbarbutton = UIBarButtonItem(customView: backbutton)
    self.navigationItem.setLeftBarButton(backbarbutton, animated: true)
  }
  
  func backView() {
    print("back button pressed")
    let _ = self.navigationController?.popViewController(animated: true)
  }
  
  func logout() {
    
  }
  
  func customizeView(){
    
    imageBanner.layer.cornerRadius = 10
    self.imageBanner.layer.masksToBounds = true
    
    btnSMS.borderWidth = 1
    btnSMS.borderColor = UIColor.blue
    
    btnFacebook.borderWidth = 1
    btnFacebook.borderColor = UIColor.blue
    
    btnWhatsApp.borderWidth = 1
    btnWhatsApp.borderColor = UIColor.blue
    
  }
}
