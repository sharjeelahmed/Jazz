//
//  RedeemPinView.swift
//  Vouch365
//
//  Created by Veer Suthar on 29/04/2017.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

protocol RedeemPinViewDelegate: class {
  func didClosePinView()
  func requestServerWithPin(pin: String)
}

class RedeemPinView: UIView {
  
  weak var delegate:RedeemPinViewDelegate?
  
  @IBOutlet weak var image_logo: UIImageView!
  @IBOutlet weak var label_description: UILabel!
  @IBOutlet weak var label_customerName: UILabel!
  @IBOutlet weak var label_customerSaving: UILabel!
  @IBOutlet weak var button_reviewRules: UIButton!
  @IBOutlet weak var button_closeView: UIButton!
  
  @IBOutlet weak var fieldOneLabel: UILabel!
  @IBOutlet weak var fieldTwoLabel: UILabel!
  @IBOutlet weak var fieldThreeLabel: UILabel!
  @IBOutlet weak var fieldFourLabel: UILabel!
  @IBOutlet weak var inputField: UITextField!
  
  @IBOutlet weak var label_enterpin: UILabel!
  
  var text: String = ""
  var isPINRenter = true
  var labels = [Any]()
  
  var view: UIView!
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
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
    let nib = UINib(nibName: "RedeemPinView", bundle: bundle)
    let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    
    return view
  }
  
  override init(frame: CGRect) {
    // 1. setup any properties here
    
    // 2. call super.init(frame:)
    super.init(frame: frame)
    
    // 3. Setup view from .xib file
    xibSetup()
    
   // label_enterpin.text = "Please Enter Customer Pin"
	label_enterpin.text = "Please Enter Service Provider Pin"
	self.view.backgroundColor = UIColor.gray
    
    inputField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    
    inputField.isHidden = true
    inputField.keyboardType = .numberPad
    inputField.delegate = self
    inputField.isSecureTextEntry = true
    inputField.autocorrectionType = .no
    inputField.becomeFirstResponder()
    
    labels = [fieldOneLabel, fieldTwoLabel, fieldThreeLabel, fieldFourLabel]
    
    updatePasscodeDisplay()
  }
  
  required init?(coder aDecoder: NSCoder) {
    // 1. setup any properties here
    
    // 2. call super.init(coder:)
    super.init(coder: aDecoder)
    
    // 3. Setup view from .xib file
    xibSetup()
  }
  
  
  func updatePasscodeDisplay() {
    let length: Int = (inputField.text?.count)!
    for i in 0..<4 {
      let label: UILabel? = (labels[i] as? UILabel)
      label?.text = (i < length) ? "●" : ""
    }
  }
  
	@objc public func textFieldDidChange (sender: UITextField) {
    
    updatePasscodeDisplay()
    
    if sender.text?.count == 4 {
      if !isPINRenter {
        resetInput()
        if inputField.text! == User.getPinCode() {
          UIApplication.shared.endIgnoringInteractionEvents()
          label_enterpin.text = "Please Enter Service Provider Pin"
          self.view.backgroundColor = UIColor.gray
          isPINRenter = true
        }else {
          label_enterpin.text = "Incorrect Pin, Please re-enter!"
          isPINRenter = false
        }
      }else {
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        resetInput()
        delegate?.requestServerWithPin(pin: inputField.text!)
      }
    }
  }
  
  func resetInput() {
    
    print("Text Field input is \(inputField.text!)")
    UIApplication.shared.beginIgnoringInteractionEvents()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      // your code here
      self.inputField.text = ""
      self.updatePasscodeDisplay()
      UIApplication.shared.endIgnoringInteractionEvents()
    }
  }
  
  func wrongServiceProviderPin(error: String) {
    //label_enterpin.text = error
    //label_enterpin.text = "Incorrect Service Provider Pin. Please re-enter"
    UIApplication.shared.endIgnoringInteractionEvents()
  }
  
  @IBAction func dismissView(_ sender: UIButton) {
    delegate?.didClosePinView()
  }
}

extension RedeemPinView : UITextFieldDelegate {
  
}
