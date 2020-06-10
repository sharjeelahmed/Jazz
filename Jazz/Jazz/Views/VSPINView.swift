//
//  VSPINView.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/26/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit
import AudioToolbox

protocol PINViewDelegate:class {
  func callTextField()
  func closeView()
}


class VSPINView: UIView {
  
  weak var pinViewDelegate: PINViewDelegate?
  
  let kGCPINViewControllerDelay = 0.3
  var __dismiss: Bool = false
  
  enum GCPINViewControllerMode : Int {
    /*
     
     Create a new passcode. This allows the user to enter a new passcode then
     imediately verify it.
     
     */
    case create = 0
    /*
     
     Verify a passcode. This allows the user to input a passcode then have it
     checked by the caller.
     
     */
    case verify
  }
  typealias GCPasscodeVerifyBlock = (_ code: String) -> Bool
  
  
  var view: UIView!
  
  @IBOutlet weak var fieldOneLabel: UILabel!
  @IBOutlet weak var fieldTwoLabel: UILabel!
  @IBOutlet weak var fieldThreeLabel: UILabel!
  @IBOutlet weak var fieldFourLabel: UILabel!
  @IBOutlet weak var inputField: UITextField!
  @IBOutlet var errorLabel: UILabel!
  
  var text: String = ""
  
  var labels = [Any]()
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
  //  @IBOutlet weak var imageview: UIImageView!
  
  //  let jeremyGif = UIImage.gif(name: "loader")
  
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
    
    //    NotificationCenter.default.addObserver(self, selector: #selector(self.textDidChange), name: NSNotification.Name(rawValue: "UITextFieldTextDidChangeNotification"), object: nil)
    
  }
  
  func updatePasscodeDisplay() {
    let length: Int = (inputField.text?.count)!
    for i in 0..<4 {
      let label: UILabel? = (labels[i] as? UILabel)
      label?.text = (i < length) ? "●" : ""
    }
  }

   @IBAction func closeView(_ sender: Any) {
    
    pinViewDelegate?.closeView()
  }
  
  func xibSetup() {
    view = loadViewFromNib()
    
    // use bounds not frame or it'll be offset
    view.frame = bounds
    
    // Make the view stretch with containing view
	view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
    
    
    // setup labels list
    labels = [fieldOneLabel, fieldTwoLabel, fieldThreeLabel, fieldFourLabel]
    
    // setup input field
    
    inputField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    inputField.isHidden = true
    inputField.keyboardType = .numberPad
    inputField.delegate = self
    inputField.isSecureTextEntry = true
    inputField.autocorrectionType = .no
    inputField.becomeFirstResponder()
    
    updatePasscodeDisplay()
    
    addSubview(view)
  }
  
  func loadViewFromNib() -> UIView {
    
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "VSPINView", bundle: bundle)
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
  
	@objc public func textFieldDidChange (sender: UITextField) {
  
    updatePasscodeDisplay()

    if sender.text?.count == 4 {
      resetInput()
    }
  }
  
  func resetInput() {
    UIApplication.shared.beginIgnoringInteractionEvents()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      // your code here
      self.inputField.text = ""
      self.updatePasscodeDisplay()
      UIApplication.shared.endIgnoringInteractionEvents()
    }
  }
}

extension VSPINView: UITextFieldDelegate {
  // UITextField Delegates
  func textFieldDidBeginEditing(_ textField: UITextField) {
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
  }
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    return true;
  }
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    return true;
  }
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    return true;
  }
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    return true;
  }
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder();
    return true;
  }
}

