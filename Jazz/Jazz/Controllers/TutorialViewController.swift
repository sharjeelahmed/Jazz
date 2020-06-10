//
//  TutorialViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 26/04/2017.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
  
  @IBOutlet weak var pageControl: UIPageControl!
  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var button_skip: UIButton!
  @IBOutlet weak var button_next: UIButton!
  
  var tutorialPageViewController: TutorialPageViewController? {
    didSet {
      tutorialPageViewController?.tutorialDelegate = self
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigation()
    pageControl.addTarget(self, action: #selector(TutorialViewController.didChangePageControlValue), for: .valueChanged)
  }
  
  
  func setupNavigation() {
    
    self.navigationItem.title = "Instructions"
    
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
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let tutorialPageViewController = segue.destination as? TutorialPageViewController {
      tutorialPageViewController.tutorialDelegate = self
      self.tutorialPageViewController = tutorialPageViewController
    }
  }
  
  
  @IBAction func didSelectSkip(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func didSelectNext(_ sender: UIButton) {
    
    if sender.titleLabel?.text == "FINISH" {
      self.dismiss(animated: true, completion: nil)
    }else {
      self.tutorialPageViewController?.scrollToNextViewController()
    }
  }
  
  /**
   Fired when the user taps on the pageControl to change its current page.
   */
	@objc func didChangePageControlValue() {
    tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage)
  }
}

extension TutorialViewController: TutorialPageViewControllerDelegate {
  
  func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
                                  didUpdatePageCount count: Int) {
    pageControl.numberOfPages = count
  }
  
  func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
                                  didUpdatePageIndex index: Int) {
    pageControl.currentPage = index
    
  }
  
}
