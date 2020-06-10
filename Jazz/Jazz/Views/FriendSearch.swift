//
//  FriendSearch.swift
//  Vouch365
//
//  Created by Veer Suthar on 9/5/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

protocol FriendSearchViewDelegate : class {
  func passFriend(friend: Friend)
}

class FriendSearch: UIView {
  
  weak var my_delegate: FriendSearchViewDelegate?
  var array_friends :Array <Friend> = Array()
  
  @IBOutlet weak var button_cancel: UIButton!
  @IBOutlet weak var button_send: UIButton!
  
  @IBOutlet weak var textfield_friendName: UITextField!
  @IBOutlet weak var textfield_email: UITextField!
  @IBOutlet weak var table_findFriend: UITableView!
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
  class func instanceFromNib() -> FriendSearch {
    return UINib(nibName: "FriendSearch", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! FriendSearch
  }
  
	 @objc func textFieldDidChange(_ textField: UITextField) {
    
    if textField.tag == 200 {
      print("VS Email Text is \(String(describing: textField.text))")
    }else if textField.tag == 300 {
      print("VS Name Text is \(String(describing: textField.text))")
      
      self.table_findFriend.isHidden = false

      if let i = array_friends.index(where: { $0.fname == textField.text }) {
        let object = array_friends[i]
        print("Object is \(object)")
      }
    }
  }
}

extension FriendSearch: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array_friends.count
  }
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell: UITableViewCell = {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
      }
      return cell
    }()
    
    var friend : Friend = self.array_friends [indexPath.row]
    cell.backgroundColor = UIColor.clear
    cell.textLabel?.text = friend.email
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 25
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("array object is \(array_friends[indexPath.row])")
    let friend = array_friends [indexPath.row]
    my_delegate?.passFriend(friend: friend)
    self.textfield_friendName.text = "\(friend.fname!) \(friend.lname!)"
  }
}
