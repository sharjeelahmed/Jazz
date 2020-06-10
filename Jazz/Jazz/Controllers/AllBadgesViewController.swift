//
//  AllBadgesViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 6/6/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class AllBadgesViewController: UIViewController {
  
  @IBOutlet weak var tableview_allbadges: UITableView!
  
  var array_allbadges: Array<Badge> = Array()
  
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
    
    self.navigationItem.title = "Badges"
    
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
    backbutton.addTarget(self, action: #selector(AllBadgesViewController.backView), for: .touchUpInside)
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

extension AllBadgesViewController : UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array_allbadges.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "AllLevelBagdeTableViewCell") as! AllLevelBagdeTableViewCell
    
    let badge = array_allbadges[indexPath.row]
    cell.label_title.text = badge.name
    cell.label_description.text = badge.desc
    
    let url = URL(string: badge.image!)
    
    cell.imageview_image.kf.setImage(with: url)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //    let category : Offer = dummySearchResultArray[indexPath.row] as! Offer
    //    fetchCompanyDetail(sp_id: category.sp_ID!,user_id: User.getUserID())
    
  }
}
