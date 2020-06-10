//
//  NotificationViewController.swift
//  Voucher365
//
//  Created by Veer Suthar on 3/4/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit
import SafariServices

class NotificationViewController: UIViewController {
  
  @IBOutlet weak var tableview_notification: UITableView!
  @IBOutlet weak var view_no_notification: UIView!
  
  var array_notifcation : Array<NotificationVeer> = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
	tableview_notification.rowHeight = UITableView.automaticDimension
    tableview_notification.estimatedRowHeight = 320
    
    setupNavigation()
    
  }
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    self.tabBarController?.tabBar.isHidden = false

//    if User.getUserID() ==  "1"{
//        
//            // perhaps use action.title here
//            Bootstrapper.reset()
//            Bootstrapper.showLogin()
//        return
//        
//    }

    self.view_no_notification.isHidden = true
    self.tableview_notification.isHidden = true
    
    ServiceWrapper.getNotification(userId: User.getUserID(), city: User.getCity()) { (success, response) in
      if success {
        print("Notofication \(response)")
        let notification = response.value(forKey: "data")
        
        self.array_notifcation = NotificationVeer.getArrayOfNotification(array: notification as! Array<Dictionary<String, Any>>)
        
        if (self.array_notifcation.count > 0) {
          self.view_no_notification.isHidden = true
          self.tableview_notification.isHidden = false
          self.tableview_notification.reloadData()
        }else {
          self.view_no_notification.isHidden = false
          self.tableview_notification.isHidden = true
        }
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setupNavigation() {
    
    self.navigationItem.title = "Notifications"
    
    self.navigationController?.navigationBar.barTintColor = UIColor.white
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    
    self.tabBarController?.tabBar.barTintColor = UIColor.white
    self.tabBarController?.tabBar.isTranslucent = false
    self.tabBarController?.tabBar.backgroundImage = UIImage()
    self.tabBarController?.tabBar.shadowImage = UIImage()
    
	self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 13)!]
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


extension NotificationViewController: UITableViewDelegate, UITableViewDataSource
{
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let notification = self.array_notifcation [indexPath.row]
    
    //linktype = spid =
    if ((notification.linktype == "spid") || (notification.linktype == "url") || (notification.linktype == "tab") || (notification.linktype == "post")) {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! NotificationImageTableViewCell
       // let url = URL(string: notification.header!)
        let url_banner = URL(string: "\(Constants.baseUrlStagging)/\(notification.header!)")

        cell.banner_image.kf.setImage(with: url_banner)
        //let logoUrl = URl(string: notification.logo!)
        cell.title_lbl.text = notification.name!
        cell.lbl_desc.text = notification.desc!
        cell.delegate = self
        cell.indexPath = indexPath
        
        if notification.linktype == "spid"{
            cell.btn_nav.setTitle("Redeem Now",for: .normal)
            cell.btn_nav.isHidden = false


        }else if notification.linktype == "url"{
            cell.btn_nav.setTitle("Read More",for: .normal)
            cell.btn_nav.isHidden = false

            
        }else if notification.linktype == "tab"{
            cell.btn_nav.setTitle("Redeem Now",for: .normal)
            cell.btn_nav.isHidden = false

            
        }else if notification.linktype == "post"{
            //cell.btn_nav.setTitle("Redeem Now",for: .normal)
            cell.btn_nav.isHidden = true
        }

    
        cell.contentView.backgroundColor = UIColor.clear
      
      let whiteRoundedView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: 320))
      
      whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
      whiteRoundedView.layer.masksToBounds = false
      whiteRoundedView.layer.cornerRadius = 2.0
      whiteRoundedView.layer.shadowOffset = CGSize(width: 1, height: 1)
      whiteRoundedView.layer.shadowOpacity = 0.2
      
      cell.contentView.addSubview(whiteRoundedView)
		cell.contentView.sendSubviewToBack(whiteRoundedView)
      
      return cell
        
    } else {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as! NotificationTextTableViewCell
        
        let url = URL(string: "\(Constants.baseUrlStagging)/\(notification.logo!)")

        cell.cell_image.kf.setImage(with: url)
        cell.notif_title.text = notification.name!
        cell.detail_lbl.text = notification.desc!
        cell.contentView.backgroundColor = UIColor.clear
    
      let whiteRoundedView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 105))
      
      whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
      whiteRoundedView.layer.masksToBounds = false
      whiteRoundedView.layer.cornerRadius = 2.0
      whiteRoundedView.layer.shadowOffset = CGSize(width: 1, height: 1)
      whiteRoundedView.layer.shadowOpacity = 0.2
      
      cell.contentView.addSubview(whiteRoundedView)
		cell.contentView.sendSubviewToBack(whiteRoundedView)
      
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 20; // space b/w cells
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
    return self.array_notifcation.count
  }
    
    func fetchCompanyDetail(sp_id: String, user_id: String) {
        
        Utilities.showLoader(controller: self)
        
        ServiceWrapper.getCompanyDetail(sp_id: sp_id, user_id: user_id) {
            (success,response) in
            if success{
                print(response)
                
                var local_company: CompanyDetail = CompanyDetail()
                local_company.setDataFromServer(response)
                
                let company = local_company
                
                let viewController:RootOfferDetailsViewController = UIStoryboard(name: "Main-Pso", bundle: nil).instantiateViewController(withIdentifier: "RootOfferDetailsViewController") as! RootOfferDetailsViewController
               viewController.company = company
                
                viewController.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    
    
}

extension NotificationViewController:NotificationImageTableViewCellProtocol{
    
    func btnPressed(indexpath:IndexPath){
        
        let notification = self.array_notifcation [indexpath.row]
        
        if notification.linktype == "spid"{
            
            fetchCompanyDetail(sp_id: notification.spid!,user_id: User.getUserID())

            
        }else if notification.linktype == "url"{
            if let url = URL(string:notification.url ?? "https://www.google.com/" ) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:])
                } else {
                    // Fallback on earlier versions
                    if let url = URL(string:notification.url ?? "https://www.google.com/" ) {
                    let svc = SFSafariViewController(url: url)
                    present(svc, animated: true, completion: nil)
                    }
                }
            }
            
        }else if notification.linktype == "tab"{
            
        }

        
    }

}
