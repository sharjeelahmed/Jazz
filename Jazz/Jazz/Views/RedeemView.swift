//
//  RedeemView.swift
//  Vouch365
//
//  Created by Veer Suthar on 07/04/2017.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

protocol RedeemViewDelegate: class {
  func didCloseView()
    func showInputViewRedeem(eligible : Bool)
}


class RedeemView: UIView {
  
  weak var delegate:RedeemViewDelegate?
  
  @IBOutlet weak var image_background: UIImageView!
  @IBOutlet weak var image_logo: UIImageView!
  @IBOutlet weak var label_offerName: UILabel!
  @IBOutlet weak var label_description: UILabel!
  @IBOutlet weak var label_customerName: UILabel!
  @IBOutlet weak var label_customerSaving: UILabel!
  @IBOutlet weak var button_redeem: UIButton!
  @IBOutlet weak var button_reviewRules: UIButton!
  @IBOutlet weak var button_closeView: UIButton!
  
  
  var view: UIView!
  func xibSetup() {
    view = loadViewFromNib()
    
    // use bounds not frame or it'll be offset
    view.frame = bounds
    
    // Make the view stretch with containing view
	view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
    
    
    addSubview(view)
  }
  
  func loadViewFromNib() -> UIView {
    
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "RedeemView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    return view
  }
  
  override init(frame: CGRect) {
    // 1. setup any properties here
    
    // 2. call super.init(frame:)
    super.init(frame: frame)
    
    // 3. Setup view from .xib file
    xibSetup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    // 1. setup any properties here
    
    // 2. call super.init(coder:)
    super.init(coder: aDecoder)
    
    // 3. Setup view from .xib file
    xibSetup()
  }
  
  @IBAction func didPressCloseView(_ sender: Any) {
    delegate?.didCloseView()
  }
  
  @IBAction func didPressRedeem(_ sender: Any) {
    if let btn : UIButton = sender as? UIButton {
        if btn.title(for: .normal) == "Redeem" {
            delegate?.showInputViewRedeem(eligible: true)
        }
        else {
            delegate?.showInputViewRedeem(eligible: false)

        }
    }
  }
  
  @IBAction func didPressReviewRules(_ sender: Any) {
    
  }
    
    
    func showSucessStory(sender : String) {
        self.button_redeem.isHidden = true
    }
}
