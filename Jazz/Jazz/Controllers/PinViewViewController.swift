//
//  PinViewViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/27/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class PinViewViewController: UIViewController {
  
  @IBOutlet weak var button_dismiss: UIButton!
  
  @IBOutlet weak var fieldOneLabel: UILabel!
  @IBOutlet weak var fieldTwoLabel: UILabel!
  @IBOutlet weak var fieldThreeLabel: UILabel!
  @IBOutlet weak var fieldFourLabel: UILabel!
  @IBOutlet weak var inputField: UITextField!
  @IBOutlet var errorLabel: UILabel!
  
  @IBOutlet weak var label_enterpin: UILabel!
  @IBOutlet weak var label_forgot: UILabel!
  
  var isFromPreferennces = false
  
  var text: String = ""
  var isPINRenter = false
  
  var labels = [Any]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    //IQKeyboardManager.sharedManager().enable = false
    
    IQKeyboardManager.shared.enable = false

    if self.isFromPreferennces {
      label_enterpin.text = "Please enter a new Pin"
      button_dismiss.isHidden = false
    }else {
      label_enterpin.text = "Please create a Pin\nYou will use it to secure redeem offers"
    }
    
    label_forgot.isHidden = true
    
    
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
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
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
      label_enterpin.text = "Please Confirm your Pin by re-entering it now"
      label_forgot.isHidden = false
      if !isPINRenter {
        text = inputField.text!
        resetInput()
        isPINRenter = true
      }else {
        if text == inputField.text! {
          //Correct
          label_enterpin.text = "Thank You."
          label_forgot.isHidden = true
          User.setPinCode(pin_code: text)
          UIApplication.shared.beginIgnoringInteractionEvents()
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // your code here
            
            self.inputField.resignFirstResponder()
            
            if self.isFromPreferennces {
              self.dismiss(animated: true, completion: nil)
            }else {
              Bootstrapper.showHome()
              
            }
            
            UIApplication.shared.endIgnoringInteractionEvents()
          }
          
        }else {
          
          //Wrong
          resetInput()
          label_enterpin.text = "Incorrect Pin, Please re-enter!"
        }
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
  
  
  @IBAction func dismissView(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
}

extension PinViewViewController : UITextFieldDelegate {
  
}
