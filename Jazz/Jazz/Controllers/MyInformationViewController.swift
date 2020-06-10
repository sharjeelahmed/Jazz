//
//  MyInformationViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/15/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import SwiftDate

class MyInformationViewController: UIViewController {
  
  var array_myprofile = ["First name", "Last name", "Gender", "Email", "Telephone", "Date of birth", "City","Currency","Membership Valid Till","Entertainer Newsletter Subscription","3rd Party Newsletter Subscription",]
  var array_data: Array<String> = []
  
	var dateOfBirthMinDate : Date? = Int(100).years.ago
   var dateOfBirthMaxDate : Date? = Int(18).years.ago
  
  var genderTypes = [Any]()
  var genderTypeString = [String]()
  var userBirthDate = Date()
  var controllerType:String!
  
  @IBOutlet weak var tableInformation: UITableView!
  @IBOutlet var ageLimitView: UIView!
  
  var dob : String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    setupNavigation()
    
    setUpView()
  }
  
  func setUpView() {
    array_data.append(User.getFirstName())
    array_data.append(User.getLastName())
    array_data.append(User.getGender())
    array_data.append(User.getUserEmail())
    array_data.append(User.getTelephone())
    array_data.append(User.getDOB())
    
    dob = User.getDOB()
    
    let city = User.getCity()
    array_data.append(city)
   
    
    array_data.append(User.getCurrency())
    array_data.append(User.getMembershipDate())
    
    tableInformation.reloadData()
  }
  
  func setupNavigation() {
    
    self.navigationItem.title = "My Information"
    
    self.navigationController?.navigationBar.barTintColor = UIColor.white
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    
    
    self.tabBarController?.tabBar.barTintColor = UIColor.white
    self.tabBarController?.tabBar.isTranslucent = false
    self.tabBarController?.tabBar.backgroundImage = UIImage()
    self.tabBarController?.tabBar.shadowImage = UIImage()
    
	self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 13)!]
    
    let cancel = UIButton(type: .custom)
    cancel.setTitle("Cancel", for: .normal)
    cancel.setTitleColor(.gray, for: .normal)
    cancel.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 16)
    cancel.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
	cancel.titleEdgeInsets = UIEdgeInsets(top: 0, left: -35, bottom: 0, right: 35);
    cancel.addTarget(self, action: #selector(MyInformationViewController.backView), for: .touchUpInside)
    let cancelbarbutton = UIBarButtonItem(customView: cancel)
    self.navigationItem.setLeftBarButton(cancelbarbutton, animated: true)
    
    let update = UIButton(type: .custom)
    update.setTitle("Update", for: .normal)
    update.setTitleColor(.gray, for: .normal)
    update.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 16)
    update.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
	update.titleEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: -35);
    update.addTarget(self, action: #selector(MyInformationViewController.update), for: .touchUpInside)
    let updatebarbutton = UIBarButtonItem(customView: update)
    self.navigationItem.setRightBarButton(updatebarbutton, animated: true)
    
  }
  
	@objc func update(){
    
    print("update clicked")
    
    //user_ID
    //fname
    //lname
    //email
    //phone
    //sub_ent
    //sub_3rd
    
    
    let indexPath_fname = IndexPath(row: 0, section: 0)
    let cell_fname: DataWithLockTableViewCell = self.tableInformation.cellForRow(at: indexPath_fname) as! DataWithLockTableViewCell
    let fname = cell_fname.textfield_data.text
    
    
    let indexPath_lname = IndexPath(row: 1, section: 0)
    let cell_lname: DataWithLockTableViewCell = self.tableInformation.cellForRow(at: indexPath_lname) as! DataWithLockTableViewCell
    let lname = cell_lname.textfield_data.text
    
    let indexPath_gender = IndexPath(row: 2, section: 0)
    let cell_gender: DataWithoutLockTableViewCell = self.tableInformation.cellForRow(at: indexPath_gender) as! DataWithoutLockTableViewCell
    let gender = cell_gender.label_data.text
    
    let indexPath_email = IndexPath(row: 3, section: 0)
    let cell_email: DataWithoutLockTableViewCell = self.tableInformation.cellForRow(at: indexPath_email) as! DataWithoutLockTableViewCell
    let email = cell_email.label_data.text
    
    let indexPath_phone = IndexPath(row: 4, section: 0)
    let cell_phone: DataWithLockTableViewCell = self.tableInformation.cellForRow(at: indexPath_phone) as! DataWithLockTableViewCell
    let phone = cell_phone.textfield_data.text
    
    let indexPath_sub_ent = IndexPath(row: 9, section: 0)
    let cell_sub_ent: DataWithSwitchTableViewCell = self.tableInformation.cellForRow(at: indexPath_sub_ent) as! DataWithSwitchTableViewCell
    let sub_ent_state = cell_sub_ent.switch_data.isOn
    
    let indexPath_sub_3rd = IndexPath(row: 10, section: 0)
    let cell_sub_3rd: DataWithSwitchTableViewCell = self.tableInformation.cellForRow(at: indexPath_sub_3rd) as! DataWithSwitchTableViewCell
    let sub_3rd_state = cell_sub_3rd.switch_data.isOn
    
    let dict: NSDictionary = ["user_ID":User.getUserID(),
                              "fname":fname!,
                              "lname":lname!,
                              "gender":gender!,
                              "email":email!,
                              "phone":phone!,
                              "dob":dob,
                              "sub_ent":sub_ent_state,
                              "sub_3rd":sub_3rd_state]
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.postUserUpdate(requestObject: dict as NSDictionary) {
      (success, response) in
      print("response = ", response);
      if success{
        
        self.verifySession()
        
        //        let array_history = response.value(forKey: "data")
        //
        //        self.array_history = History.getArrayOfHistory(array: array_history as! Array <Dictionary <String, Any>>)
        //
        //        if (self.array_history.count > 0) {
        //          self.view_no_history.isHidden = true
        //          self.tableview_history.isHidden = false
        //          self.tableview_history.reloadData()
      }else {
        //          self.view_no_history.isHidden = false
        //          self.tableview_history.isHidden = true
      }
    }
  }
  
  func verifySession(){
    //    let dict: NSDictionary = ["user_ID":User.getUserID(),"sessionID": User.getUserSessionID()]
    
    let dict: NSDictionary = ["sessionID":User.getUserSessionID()]
    
    ServiceWrapper.sessionValidate(requestObject: dict as NSDictionary) {
      (success, response) in
      print("response = %@", response);
      
      
      if success{
        
        User.setUserEmail(email:response.value(forKey: "email") as! String)
        User.setFirstName(userName:response.value(forKey: "fname") as! String)
        User.setLastName(userName:response.value(forKey: "lname") as! String)
        if let dob = response.value(forKey: "dob") {
          User.setDOB(userName:dob as? String ?? "")
        }
        
        if let phone = response.value(forKey: "phone") {
          User.setTelephone(userName:phone as? String ?? "")
        }

        
        if let gender = response.value(forKey: "gender") {
          User.setGender(userName:gender as? String ?? "")
        }
        
        User.setUserID(user_ID:response.value(forKey: "user_ID") as! String)
        User.setUserSessionID(session: response.value(forKey: "sessionID") as! String)
        
        self.setUpView()
        
        DispatchQueue.main.async {
          self.dismiss(animated: true, completion: nil)
        }
        
      }else{
        print("Failed")
      }
    }
  }
  
  
	@objc func backView() {
    dismiss(animated: true, completion: nil)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
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
  
}


// MARK: - UITableViewDataSource
extension MyInformationViewController : UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array_myprofile.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.row == 4{
      let cell = tableInformation.dequeueReusableCell(withIdentifier: "DataWithLockTableViewCell", for: indexPath) as! DataWithLockTableViewCell
      cell.label_title.text = array_myprofile[indexPath.row]
      cell.textfield_data.text = array_data[indexPath.row]
      cell.textfield_data.delegate = self
      cell.textfield_data.keyboardType = .phonePad
      return cell
    }
    
    if indexPath.row < 2{
      let cell = tableInformation.dequeueReusableCell(withIdentifier: "DataWithLockTableViewCell", for: indexPath) as! DataWithLockTableViewCell
      cell.label_title.text = array_myprofile[indexPath.row]
      cell.textfield_data.text = array_data[indexPath.row]
      cell.textfield_data.delegate = self
      return cell
    }else if indexPath.row >= 2 && indexPath.row <= 8{
      let cell = tableInformation.dequeueReusableCell(withIdentifier: "DataWithoutLockTableViewCell", for: indexPath) as! DataWithoutLockTableViewCell
      cell.label_title.text = array_myprofile[indexPath.row]
      cell.label_data.text = array_data[indexPath.row]
      return cell
    }else{
      let cell = tableInformation.dequeueReusableCell(withIdentifier: "DataWithSwitchTableViewCell", for: indexPath) as! DataWithSwitchTableViewCell
      cell.label_title.text = array_myprofile[indexPath.row]
      return cell
    }
  }
  
  func displayDate(date: Date, cell: DataWithoutLockTableViewCell) {
    
    let calendar = Calendar.current
    
    userBirthDate = date
    
    let day = calendar.component(.day, from: date)
    let month = calendar.component(.month, from: date)
    let year = calendar.component(.year, from: date)
    
    let string_day = String(day)
    let string_month = String(month)
    let string_year = String(year)
    
    dob =  string_year + "-" + string_month + "-" + string_day
//    YYYY-MM-DD
    cell.label_data.text = string_day + "-" + string_month + "-" + string_year
  }
}

// MARK: - UITableViewDelegate
extension MyInformationViewController: UITableViewDelegate {
  // table view data source methods
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
    
    print("INdex is \(indexPath.row)")
    
    if indexPath.row == 0{
      
    }else if indexPath.row == 1{
      
    }else if indexPath.row == 2{
      //Gender
      
      let cell = self.tableInformation.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) as! DataWithoutLockTableViewCell
      
		let alertController = UIAlertController(title: nil, message: "Select Gender", preferredStyle: UIAlertController.Style.alert)
		let male = UIAlertAction(title: "Male", style: UIAlertAction.Style.default) {
        (result : UIAlertAction) -> Void in
        print("Male")
        cell.label_data.text = "Male"
      }
      alertController.addAction(male)
      
      
		let female = UIAlertAction(title: "Female", style: UIAlertAction.Style.default) {
        (result : UIAlertAction) -> Void in
        print("Female")
        cell.label_data.text = "Female"
      }
      
      alertController.addAction(female)
      
      
		let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive) {
        (result : UIAlertAction) -> Void in
        print("Cancel")
      }
      alertController.addAction(cancel)
      
      
      DispatchQueue.main.async {
        self.present(alertController, animated: true, completion: nil)
      }
      
    }else if indexPath.row == 3{
      //Email
      
    }else if indexPath.row == 4{
      //Telephone
      
    }else if indexPath.row == 5{
      //DOB
      
      let cell = self.tableInformation.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) as! DataWithoutLockTableViewCell
      
      unowned let us = self
      
      let actionSheet = ActionSheetDatePicker(title: "Select Date of Birth",
                                              datePickerMode: .date,
                                              selectedDate: us.dateOfBirthMaxDate,
                                              doneBlock:
        { (picker, date, _) in
          us.displayDate(date: date! as! Date, cell: cell)
      }, cancel: { (_) in
        //us.dob.next(nil)
      }, origin: self.view)!
      
      actionSheet.maximumDate = us.dateOfBirthMaxDate
      actionSheet.minimumDate = us.dateOfBirthMinDate
      //      actionSheet.setDoneButton(UIBarButtonItem.doneButton(title: Utilities.getValue(variable:"app.registerDoneText")))
      //      actionSheet.setCancelButton(UIBarButtonItem.cancelButton(title: Utilities.getValue(variable:"app.cancelText")))
      
      actionSheet.show()
      
      ageLimitView.frame = CGRect.init(x: 0, y: -90, width: self.view.bounds.size.width, height: 50.0)
      if (ageLimitView != nil) {
        actionSheet.pickerView.addSubview(ageLimitView)
      }
      
      
    }else if indexPath.row == 6{
      
      let cell = self.tableInformation.cellForRow(at: IndexPath(row: indexPath.row, section: 0)) as! DataWithoutLockTableViewCell
      
		let alertController = UIAlertController(title: nil, message: "Select City", preferredStyle: UIAlertController.Style.alert)
      
		let karachi = UIAlertAction(title: "Karachi", style: UIAlertAction.Style.default) {
        (result : UIAlertAction) -> Void in
        print("Karachi")
        cell.label_data.text = "Karachi"
      }
      alertController.addAction(karachi)
      
      
		let lahore = UIAlertAction(title: "Lahore", style: UIAlertAction.Style.default) {
        (result : UIAlertAction) -> Void in
        print("Lahore")
        cell.label_data.text = "Lahore"
      }
      
      alertController.addAction(lahore)
      
      
		let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive) {
        (result : UIAlertAction) -> Void in
        print("Cancel")
      }
      alertController.addAction(cancel)
      
      
      DispatchQueue.main.async {
        self.present(alertController, animated: true, completion: nil)
      }
      
      
    }else if indexPath.row == 7{
      
    }
    else if indexPath.row == 8{
      
    }else if indexPath.row == 9{
      
    }else if indexPath.row == 10{
      
    }
  }
  
}

extension MyInformationViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
