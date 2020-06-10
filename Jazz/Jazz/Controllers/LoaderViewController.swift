//
//  LoaderViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/29/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class LoaderViewController: UIViewController {
  
  @IBOutlet weak var imageview: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    
   /* imageview.animationImages = [
      UIImage(named: "GIF-01.jpg")!,
      UIImage(named: "GIF-02.jpg")!,
      UIImage(named: "GIF-03.jpg")!,
      UIImage(named: "GIF-03.jpg")!,
      UIImage(named: "GIF-04.jpg")!,
      UIImage(named: "GIF-05.jpg")!,
      UIImage(named: "GIF-06.jpg")!,
      UIImage(named: "GIF-07.jpg")!,
      UIImage(named: "GIF-08.jpg")!,
      UIImage(named: "GIF-09.jpg")!,
      UIImage(named: "GIF-10.jpg")!,
      UIImage(named: "GIF-11.jpg")!,
      UIImage(named: "GIF-12.jpg")!,
      UIImage(named: "GIF-13.jpg")!,
      UIImage(named: "GIF-14.jpg")!,
      UIImage(named: "GIF-15.jpg")!,
      UIImage(named: "GIF-16.jpg")!,
      UIImage(named: "GIF-17.jpg")!,
      UIImage(named: "GIF-18.jpg")!,
      UIImage(named: "GIF-19.jpg")!,
      UIImage(named: "GIF-20.jpg")!,
      UIImage(named: "GIF-21.jpg")!,
      UIImage(named: "GIF-22.jpg")!,
      UIImage(named: "GIF-23.jpg")!,
      UIImage(named: "GIF-24.jpg")!,
      UIImage(named: "GIF-25.jpg")!,
      UIImage(named: "GIF-26.jpg")!,
      UIImage(named: "GIF-27.jpg")!,
      UIImage(named: "GIF-28.jpg")!,
      UIImage(named: "GIF-29.jpg")!,
      UIImage(named: "GIF-30.jpg")!,
      UIImage(named: "GIF-31.jpg")!,
      UIImage(named: "GIF-32.jpg")!,
      UIImage(named: "GIF-33.jpg")!,
      UIImage(named: "GIF-34.jpg")!,
      UIImage(named: "GIF-35.jpg")!,
      UIImage(named: "GIF-36.jpg")!,
      UIImage(named: "GIF-37.jpg")!,
      UIImage(named: "GIF-38.jpg")!,
      UIImage(named: "GIF-39.jpg")!,
      UIImage(named: "GIF-40.jpg")!,
      UIImage(named: "GIF-41.jpg")!,
      UIImage(named: "GIF-42.jpg")!,
      UIImage(named: "GIF-43.jpg")!,
      UIImage(named: "GIF-44.jpg")!,
      UIImage(named: "GIF-45.jpg")!,
      UIImage(named: "GIF-46.jpg")!,
      UIImage(named: "GIF-47.jpg")!,
      UIImage(named: "GIF-48.jpg")!]
    
    imageview.animationDuration = 2.5
    imageview.animationRepeatCount = 1
    imageview.startAnimating()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
      self.animationDidFinish()
    }*/
    
    self.animationDidFinish()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func animationDidFinish() {
	if let viewController = UIStoryboard(name: "Main-Pso", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? UIViewController {
		self.present(viewController, animated: true, completion: nil)
	}
    //Bootstrapper.initializeAfterLoading()
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
