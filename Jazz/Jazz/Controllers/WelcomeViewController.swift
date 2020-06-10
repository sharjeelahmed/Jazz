//
//  WelcomeViewController.swift
//  Voucher365
//
//  Created by Veer Suthar on 3/4/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
  
  @IBOutlet weak var imageview_background: UIImageView!
  var array_images = ["background1","background2"]
  var index_image = 0
  var selectedButtonIndex: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    index_image = 0
    startBackgroundAnimation()
  }
  
  func startBackgroundAnimation() {
    
    // With Completion
	UIView.animate(withDuration: 5.0, animations: {
      self.imageview_background.alpha = 1.0
      self.imageview_background.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
      
    }, completion: {(_ finished: Bool) -> Void in
      
      print("Finished")
      
      if self.index_image == 1 {
        self.index_image = -1
      }
      self.index_image+=1
      
      print("Index is \(self.index_image)")
      
      let toImage = UIImage(named:self.array_images[self.index_image])
      UIView.transition(with: self.imageview_background,
                        duration: 0.3,
                        options: .transitionCrossDissolve,
                        animations: {
                          self.imageview_background.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                          self.imageview_background.image = toImage
                          
      },
                        completion: { (finished: Bool) in
                          if finished {
                            self.startBackgroundAnimation()
                          }
      })
      
    })
    
    
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
    
    if (segue.identifier == "sw_root") {
      // pass data to next view
      let nextStep:RootViewController = segue.destination as! RootViewController
      nextStep.selectedButtonIndex = selectedButtonIndex
    }
  }
  
  func setupView() {
    //
  }
  
  @IBAction func didPressedSkip(_ sender: UIButton) {
    /*
     let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as UIViewController
     self.present(viewController, animated: false, completion: nil)
     
     */
  }
  
  @IBAction func didPressedRegister(_ sender: UIButton) {
    selectedButtonIndex = 1
    self.performSegue(withIdentifier: "sw_root", sender: nil)
  }
  
  @IBAction func didPressedTour(_ sender: UIButton) {
    self.performSegue(withIdentifier: "sw_tutorial", sender: nil)
  }
  
  @IBAction func didPressedSignIn(_ sender: UIButton) {
    selectedButtonIndex = 0
    self.performSegue(withIdentifier: "sw_root", sender: nil)
  }
  @IBAction func skipAction(_ sender: Any) {
    
    let optionMenu = UIAlertController(title: nil, message: "Either signup or login to mobile app to enjoy the complete application excess", preferredStyle: .alert)
    let skip = UIAlertAction(title: "Skip", style: .destructive, handler: {
      (alert: UIAlertAction!) -> Void in
      Bootstrapper.showHome()
    })
    
    let signIn = UIAlertAction(title: "Login", style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
      self.selectedButtonIndex = 0
      self.performSegue(withIdentifier: "sw_root", sender: nil)
    })
    
    let signUp = UIAlertAction(title: "Register", style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
      self.selectedButtonIndex = 1
      self.performSegue(withIdentifier: "sw_root", sender: nil)
    })
    
    optionMenu.addAction(signUp)
    optionMenu.addAction(signIn)
    optionMenu.addAction(skip)
    
    self.present(optionMenu, animated: true, completion: nil)
  }
}
