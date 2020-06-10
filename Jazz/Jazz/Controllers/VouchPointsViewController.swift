//
//  VouchPointsViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 03/06/2017.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class VouchPointsViewController: UIViewController {
  
  var delegate:ProfileViewController?
  
  @IBOutlet weak var label_pointAvailable: UILabel!
  @IBOutlet weak var label_pointsUsed: UILabel!
  @IBOutlet weak var label_pointsRedeemed: UILabel!
  @IBOutlet weak var button_pings: UIButton!
  @IBOutlet weak var button_reimbursement: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func purchasePings(_ sender: UIButton) {
    
    let userDict = ["userID":User.getUserID()] as [String : Any]
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.purchasePing(requestObject: userDict as NSDictionary) {
      (success, response) in
      print("response = %@", response);
      if success{
               let message = response.value(forKey: "desc") as! String
                self.showAlert(message: message)
      }else{
        print("Failed")
                let message = response.value(forKey: "desc") as! String
                self.showAlert(message: message)
      }
    }
    
  }
  
  @IBAction func purchaseReimbursement(_ sender: UIButton) {
    
    let userDict = ["userID":User.getUserID()] as [String : Any]
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.reimbadd(requestObject: userDict as NSDictionary) {
      (success, response) in
      print("response = %@", response);
      if success{
               let message = response.value(forKey: "desc") as! String
                self.showAlert(message: message)
      }else{
        print("Failed")
                let message = response.value(forKey: "desc") as! String
                self.showAlert(message: message)
      }
    }
    
  }
    
    func showAlert( message: String){
        // the alert view
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        //    AppDelegate.getInstatnce().window?.rootViewController?.present(alert, animated: true, completion: nil)
        //    self.present(alert, animated: true, completion: nil)
        
        // change to desired number of seconds (in this case 5 seconds)
        let when = DispatchTime.now() + 4
        
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
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
