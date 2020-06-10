//
//  ProductViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/15/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
  
  @IBOutlet weak var webview_products: UIWebView!
  
  var array_products = ["My Information", "Create PIN", "VIP Key", "Help and Live chat", "Instructions","Redemption History","Ping History","End User License Agreement","Rules of Use", "AppVersion v1.0"]
  
  @IBOutlet weak var tableview: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    setupNavigation()
    
    //https://vouch365.com/buy-products
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if User.getUserID() ==  "1"{
      //        let alert = UIAlertController(title: "Alert", message: "Please login to continue voucher!", preferredStyle: UIAlertControllerStyle.alert)
      //        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
      //        alert.addAction(UIAlertAction(title: "Login", style: .default) { action in
      // perhaps use action.title here
      Bootstrapper.reset()
      Bootstrapper.showLogin()
      //        })
      //        self.present(alert, animated: true, completion: nil)
      return
      
    }
    
    webview_products.loadRequest(URLRequest(url: URL(string: "https://vouch365.com/ecomm/")!))
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setupNavigation() {
    
    self.navigationItem.title = "Products"
    
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

// MARK: - UITableViewDataSource
extension ProductViewController : UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
    let color = UIColor.randomColor()
    cell.background_view.backgroundColor = color
    cell.label_title.textColor = color
    cell.label_price.textColor = color
    cell.label_msg.textColor = .gray
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension ProductViewController: UITableViewDelegate {
  // table view data source methods
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
    
  }
}
