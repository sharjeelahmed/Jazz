//
//  GifLoader.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/24/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class GifLoader: UIView {
  
  @IBOutlet weak var imageview: UIImageView!
  
  let jeremyGif = UIImage.gif(name: "loader")
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   
   }
   */
  
  init() {
    super.init(frame: UIScreen.main.bounds)
    //for debug validation
    return
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    //custom logic goes here
    
    self.imageview.image = jeremyGif
    
  }
  
//  class func instanceFromNib() -> UIView {
//    
//    return UINib(nibName: "GifLoader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
//  }
	
	class func instanceFromNib() -> UIView {
	   let bundle = Bundle(for: GifLoader.self)
		
	   return UINib(nibName: "GifLoader", bundle: bundle).instantiate(withOwner: nil, options: nil)[0] as! UIView
	 }
  
}


