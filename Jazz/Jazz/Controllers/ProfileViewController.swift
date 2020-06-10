//
//  ProfileViewController.swift
//  Voucher365
//
//  Created by Veer Suthar on 3/4/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {
  
  @IBOutlet weak var imageview_profile: UIImageView!
  @IBOutlet weak var scrollview_profile: UIScrollView!
  
  @IBOutlet weak var image_tab: UIImageView!
  @IBOutlet weak var button_camera: UIButton!
  @IBOutlet weak var label_userID: UILabel!
  @IBOutlet weak var label_username: UILabel!
  
  @IBOutlet weak var view_level: UIView!
  @IBOutlet weak var view_friends: UIView!
  @IBOutlet weak var view_points: UIView!
  
  var levelViewController: LevelViewController = LevelViewController()
  var vouchFriendsViewController: VouchFriendsViewController = VouchFriendsViewController()
  var vouchPointsViewController: VouchPointsViewController = VouchPointsViewController()
  
  var profile: UserProfile = UserProfile()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    setupNavigation()
    
    if User.getUserID() ==  "1"{
      Bootstrapper.reset()
      Bootstrapper.showLogin()
      return
    }
    
    image_tab.image = UIImage(named:"tab1")
    view_level.isHidden = false
    view_points.isHidden = true
    view_friends.isHidden = true
    
    getProfile(user_id: User.getUserID())
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.tabBarController?.tabBar.isHidden = false

    getProfile(user_id: User.getUserID())
  }
  
  
  func viewAllLevels() {
    self.performSegue(withIdentifier: "sw_level", sender: nil)
  }
  
  func viewAllBadges() {
    self.performSegue(withIdentifier: "sw_badge", sender: nil)
  }
  
  
  func buttonClicked() {
    print("Button Clicked")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setupNavigation() {
    
    self.navigationItem.title = "My Profile"
    
    self.navigationController?.navigationBar.barTintColor = UIColor.white
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    
    
    self.tabBarController?.tabBar.barTintColor = UIColor.white
    self.tabBarController?.tabBar.isTranslucent = false
    self.tabBarController?.tabBar.backgroundImage = UIImage()
    self.tabBarController?.tabBar.shadowImage = UIImage()
    
	self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 13)!]
    
    let reload = UIButton(type: .custom)
    reload.setImage(UIImage(named: "reload"), for: .normal)
    reload.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    reload.addTarget(self, action: #selector(ProfileViewController.refresh), for: .touchUpInside)
    let reloadbarbutton = UIBarButtonItem(customView: reload)
    
    let settings = UIButton(type: .custom)
    settings.setImage(UIImage(named: "settings"), for: .normal)
    settings.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
    settings.addTarget(self, action: #selector(ProfileViewController.settings), for: .touchUpInside)
    let settingsbarbutton = UIBarButtonItem(customView: settings)
    
    self.navigationItem.setRightBarButton(settingsbarbutton, animated: true)
    self.navigationItem.setLeftBarButton(reloadbarbutton, animated: true)
  }
  
  
  @IBAction func openTabOne(_ sender: UIButton) {
    image_tab.image = UIImage(named:"tab1")
    view_level.isHidden = false
    view_friends.isHidden = true
    view_points.isHidden = true
  }
  
  @IBAction func openTabTwo(_ sender: UIButton) {
    image_tab.image = UIImage(named:"tab2")
    view_level.isHidden = true
    view_friends.isHidden = true
    view_points.isHidden = false
  }
  
  @IBAction func openTabThree(_ sender: UIButton) {
    image_tab.image = UIImage(named:"tab3")
    view_level.isHidden = true
    view_friends.isHidden = false
    view_points.isHidden = true
  }
  
  @IBAction func openCam(_ sender: UIButton) {
    self.photoSelection()
  }
  
	@objc func refresh() {
    getProfile(user_id: User.getUserID())
  }
  
  
  func getProfile(user_id: String) {
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.getProfile(user_id: user_id) {
      (success,response) in
      if success{
        
        print(response)
        //Reload View
        
        var local_profile: UserProfile = UserProfile()
        local_profile.setDataFromServer(response)
        self.profile = local_profile
        
        self.showDataOnView(profile: self.profile)
        
      }
    }
  }
  
  func showDataOnView(profile: UserProfile) {
    
    let full_name = "\(profile.fname!) \(profile.lname!)"
    
    self.label_username.text = full_name
    self.label_userID.text = profile.email
    
    vouchPointsViewController.label_pointAvailable.text = String(describing: profile.a_vpnts!)
    vouchPointsViewController.label_pointsUsed.text = String(describing: profile.u_vpnts!)
    vouchPointsViewController.label_pointsRedeemed.text = String(describing: profile.redcnt!)
    
    let imageName = "notification-1"

    if let imageUrl =  profile.avalink {
      Utilities.loadImage(imageView:self.imageview_profile, url: imageUrl , imageNamed: imageName)
    }
    
    //    levelViewController.label_level.text = String(describing: profile.array_level[0].name!)
    //    levelViewController.label_badge.text = String(describing: profile.array_badge[0].name!)
    
    let url_level = URL(string: (profile.array_level.last?.image!)!)
    levelViewController.image_level.kf.setImage(with: url_level)
    
    
    let url_badge = URL(string: (profile.array_badge.last?.image!)!)
    levelViewController.image_badge.kf.setImage(with: url_badge)
  }
  
	@objc func settings() {
    let viewController:AccountViewController = UIStoryboard(name: "Account-Pso", bundle: nil).instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
    viewController.hidesBottomBarWhenPushed = true

    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
  func photoSelection() {
    
    let optionMenu = UIAlertController(title: nil, message: "Update Profile Image", preferredStyle: .actionSheet)
    
    let camera = UIAlertAction(title: "Camera", style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
      print("Camera")
      self.takePhoto()
    })
    
    let gallery = UIAlertAction(title: "Gallery", style: .default, handler: {
      (alert: UIAlertAction!) -> Void in
      print("Gallery")
      self.userCameraRoll()
    })
    
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
      (alert: UIAlertAction!) -> Void in
      print("Cancel")
    })
    
    optionMenu.addAction(camera)
    optionMenu.addAction(gallery)
    optionMenu.addAction(cancel)
    
    self.present(optionMenu, animated: true, completion: nil)
    
  }
  
  func takePhoto() {
    
	if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
      
      let imagePicker = UIImagePickerController()
		imagePicker.sourceType = UIImagePickerController.SourceType.camera
      imagePicker.allowsEditing = false
      imagePicker.delegate = self
      self.present(imagePicker, animated: true,
                   completion: nil)
    }
  }
  
  
  func userCameraRoll() {
    if UIImagePickerController.isSourceTypeAvailable(
		UIImagePickerController.SourceType.savedPhotosAlbum) {
      let imagePicker = UIImagePickerController()
      imagePicker.sourceType =
		UIImagePickerController.SourceType.photoLibrary
      imagePicker.allowsEditing = false
      imagePicker.delegate = self
      self.present(imagePicker, animated: true,
                   completion: nil)
    }
  }
  
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    if segue.identifier == "sw_levels" {
      levelViewController = segue.destination as! LevelViewController
      levelViewController.delegate = self
      
    }else if segue.identifier == "sw_friends" {
      vouchFriendsViewController = segue.destination as! VouchFriendsViewController
    }else if segue.identifier == "sw_points" {
      vouchPointsViewController = segue.destination as! VouchPointsViewController
    }else if segue.identifier == "sw_level" {
      let viewController = segue.destination as! AllLevelsViewController
      viewController.array_alllevels = self.profile.array_level
      
    }else if segue.identifier == "sw_badge" {
      let viewController = segue.destination as! AllBadgesViewController
      viewController.array_allbadges = self.profile.array_badge
      
    }
  }
  
  
  func fixOrientation(img:UIImage) -> UIImage {
	if (img.imageOrientation == UIImage.Orientation.up) {
      return img;
    }
    
    UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale);
    let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
    img.draw(in: rect)
    
    let normalizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext();
    return normalizedImage;
  }
  
  
  func uploadImage(gallery_image: UIImage) {
    
    var image = gallery_image
    image = fixOrientation(img: image)
    
    let jpegCompressionQuality: CGFloat = 1.0 // Set this to whatever suits your purpose
    
    var parameters = [String: String]()
    parameters["user_ID"] = String(User.getUserID())
    
    //    let base64String = image.base64EncodedStringWithOptions(NSData.Base64EncodingOptions.fromRaw(0)!)
    //    println(base64String)
    //    parameters["base64Image"] = base64String
    
	if let base64String = image.jpegData(compressionQuality: jpegCompressionQuality)?.base64EncodedString(options: .lineLength64Characters) {
      // Upload base64String to your database
      parameters["base64Image"] = base64String
    }
    
    let headers: HTTPHeaders = [ "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
                                 "cache-control": "no-cache"]
    
    let URL = try! URLRequest(url: Constants.ApiAvatarUpload, method: .post, headers: headers)
    Alamofire.upload(multipartFormData: { multipartFormData in
      for (key, value) in parameters {
        multipartFormData.append(value.data(using: .utf8)!, withName: key)
      }
    }, with: URL, encodingCompletion: {
      encodingResult in
      switch encodingResult {
      case .success(let upload, _, _):
        upload.responseJSON { response in
          
          print("Veer Suthar Image Upload Success \(response)")          
          
          let imageName = "notification-1"
          let dictionary = response.result.value as! Dictionary <String, Any>
          
          if let imageUrl = dictionary["link"]  as? String{
            User.setProfileImage(image: imageUrl)
            Utilities.loadImage(imageView:self.imageview_profile, url: imageUrl, imageNamed: imageName)
          }else {
            //Don't put anything for now.
            self.imageview_profile.image = UIImage(named:imageName)
          }
        }
      case .failure(let encodingError):
        // hide progressbas here
        print("ERROR RESPONSE: \(encodingError)")
        //self.view.hideToastActivity()
        //Utilities.showToast(error:encodingError.localizedDescription, controller: self)
      }
    })
  }
}

// MARK: - UITableViewDataSource
extension ProfileViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.backgroundView?.backgroundColor = .randomColor()
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
  // table view data source methods
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}

// MARK: - UIScrollViewDelegate
extension ProfileViewController: UIScrollViewDelegate{
  func scrollViewDidScroll(_ scrollView: UIScrollView){
    //do something
    
    let offset: CGFloat = scrollView.contentOffset.y
    let percentage: CGFloat = offset / 200
    let value: CGFloat = 200 * percentage
    // negative when scrolling up more than the top
    // driven animation
    print("percentage \(percentage) \(value)")
    imageview_profile.frame = CGRect(x: CGFloat(0), y: value, width: CGFloat(scrollView.bounds.size.width), height: CGFloat(200 - value))
  }
}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
	guard let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage else {
			fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
	}
   // let image = info[UIImagePickerControllerOriginalImage] as? UIImage
    picker.dismiss(animated: true, completion: nil)
	uploadImage(gallery_image: image)
    
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    
  }
}
