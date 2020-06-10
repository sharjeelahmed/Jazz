//
//  LevelViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 03/06/2017.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class LevelViewController: UIViewController {
  
  @IBOutlet weak var image_level: UIImageView!
  
  @IBOutlet weak var label_level: UILabel!
  @IBOutlet weak var image_badge: UIImageView!
  @IBOutlet weak var label_badge: UILabel!
  
  var delegate:ProfileViewController?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func viewAllBadges(_ sender: UIButton) {
    delegate?.viewAllBadges()
  }
  
  @IBAction func viewAllLevels(_ sender: UIButton) {
    delegate?.viewAllLevels()
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
