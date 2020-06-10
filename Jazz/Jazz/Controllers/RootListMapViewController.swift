//
//  RootListMapViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/24/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class RootListMapViewController: UIViewController , UITextFieldDelegate {
  @IBOutlet weak var collection_info: UICollectionView!
  @IBOutlet weak var searchBae: UITextField!
  @IBOutlet weak var btnSearch: UIButton!
  @IBOutlet weak var btnCity: UIButton!
  @IBOutlet weak var btnCross: UIButton!


  var array: Array <ItemListingMapViewController> = Array()
  var array_nav = Array<String>()
  var array_cat = ["Food & Drinks","Salon & Spa","Leisure","Health Care","Retail & Services","Travel"]
  
  var nextScene: ItemListingMapViewController!
  var titleOfController : String!
  var argumentToServer : String!
  
  var cat : Category!
  var voucherFromHome : Voucher = Voucher()
  var arrayOffer_all: Array<Category>! = Array<Category>()
  var arrayOffer_new: Array<Category>! = Array<Category>()
  var arrayOffer_delivery: Array<Category> = Array<Category>()
  var arrayOffer_monthly: Array<Category>! = Array<Category>()
  
  
  var selectedCategory : String = ""
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
		setNeedsStatusBarAppearanceUpdate()
		self.navigationController?.setNavigationBarHidden(true, animated: true)
		self.tabBarController?.tabBar.isHidden = true
    }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
	self.navigationController?.navigationBar.isHidden = false
    
    if voucherFromHome.linktype == "tab"{
      self.selectedCategory = voucherFromHome.tab!
    }
    else {
      self.selectedCategory = "all"
    }
    
    
    self.searchBae.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    if titleOfController == "Food & Drinks" {
      array_nav = ["Home","Food","Vouch","Online Store","Free Meal Store"]
    }
    else {
      //array_nav = ["ALL OFFERS","NEW","MONTHLY"]
    }
	
    collection_info.dataSource = self
    collection_info.delegate = self
    
    title = titleOfController
    nextScene.titleOfView = titleOfController
    fetchHomeAllOffers(categoryType: "my", categoryType2:argumentToServer)
   // fetchHomeNew(categoryType: "new", categoryType2:argumentToServer)
    //fetchHomeDelivery(categoryType: "premium", categoryType2:argumentToServer)
    //fetchHomeMonthly(categoryType: "monthly", categoryType2:argumentToServer)
  }
	@objc func textFieldDidChange(_ textField: UITextField) {
    var filteredArray : Array<Category> = Array<Category>()
    if textField.text! != "" {
      if self.selectedCategory == "new" {
        filteredArray = self.arrayOffer_new.filter {
          return ($0.name ?? "").range(of: textField.text!, options: [.caseInsensitive]) != nil
        }
      }
      else if self.selectedCategory == "all" {
        filteredArray = self.arrayOffer_all.filter {
          return ($0.name ?? "").range(of: textField.text!, options: [.caseInsensitive]) != nil
        }
      }
      else if self.selectedCategory == "delivery" {
        filteredArray = self.arrayOffer_delivery.filter {
          return ($0.name ?? "").range(of: textField.text!, options: [.caseInsensitive]) != nil
        }
      }
      else if self.selectedCategory == "monthly" {
        filteredArray = self.arrayOffer_monthly.filter {
          return ($0.name ?? "").range(of: textField.text!, options: [.caseInsensitive]) != nil
        }
      }
      print("Array is \(filteredArray.count)")
      
    }
    else {
      if self.selectedCategory == "new" {
        filteredArray = self.arrayOffer_new
      }
      else if self.selectedCategory == "all" {
        filteredArray = self.arrayOffer_all
      }
      else if self.selectedCategory == "delivery" {
        filteredArray = self.arrayOffer_delivery
      }
      else if self.selectedCategory == "monthly" {
        filteredArray = self.arrayOffer_monthly
      }
      
    }
    
    print("Array is \(filteredArray.count)")
    //        }
    self.nextScene.array_list = filteredArray
    self.nextScene.tableview_category.reloadData()
    
  }
  
  	@IBAction func didTapOnSearchBtn(_ sender: Any) {
		makeTopBarButtons(isActive:true)
	}
	
	@IBAction func didTapOnCrossBtn(_ sender: Any) {
		makeTopBarButtons(isActive:false)
		self.searchBae.text = nil
		self.textFieldDidChange(self.searchBae)
		self.view.endEditing(true)
		
	}
	
	@IBAction func didTapOnCityBtn(_ sender: Any) {
		self.dismiss(animated: true, completion: nil)
	}
	
	func makeTopBarButtons(isActive:Bool){
		isActive ? MakeTopBarSearchActive() : MakeTopBarSearchInActive()
	}
	
	func MakeTopBarSearchActive(){
		self.btnSearch.isHidden = true
		self.btnCity.isHidden = true
		self.searchBae.isHidden = false
		self.btnCross.isHidden = false
	}
	
	func MakeTopBarSearchInActive(){
		self.btnSearch.isHidden = false
		self.btnCity.isHidden = false
		self.searchBae.isHidden = true
		self.btnCross.isHidden = true
	}
	
	
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    
  }
	
	func fetchHomeAllOffers1(categoryType : String, categoryType2: String){
		
	}
  
  func fetchHomeAllOffers(categoryType : String, categoryType2: String){
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.getHomeService(cat: categoryType, cat2: categoryType2) {
      (success, response) in
      
      if success{
        for item in response.value(forKey: "data") as! Array<Any>{
          let dict: NSDictionary = item as! NSDictionary
          print(dict)
          
          self.cat  = Category()
          self.cat.setDataFromServer(dict: dict)
          //self.arrayOffer_all.add(self.cat)
          self.arrayOffer_all.append(self.cat)
          
        }
        if self.selectedCategory == "all"{
          self.nextScene.array_list = self.arrayOffer_all
          self.nextScene.tableview_category.reloadData()
        }
        
      }else{
        print("Failed")
      }
    }
  }
  
  
  
  
  func fetchHomeNew(categoryType : String, categoryType2: String){

    Utilities.showLoader(controller: self)
    
    ServiceWrapper.getHomeService(cat: categoryType, cat2: categoryType2) {
      (success, response) in
      
      if success{
        for item in response.value(forKey: "data") as! Array<Any>{
          let dict: NSDictionary = item as! NSDictionary
          print(dict)
          
          self.cat  = Category()
          self.cat.setDataFromServer(dict: dict)
          self.arrayOffer_new.append(self.cat)
          
        }
      }else{
        print("Failed")
      }
      if self.selectedCategory == "new"{
        self.nextScene.array_list = self.arrayOffer_new
        self.nextScene.tableview_category.reloadData()
      }
      
    }
  }
  
  func fetchHomeDelivery(categoryType : String, categoryType2: String){
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.getHomeService(cat: categoryType, cat2: categoryType2) {
      (success, response) in
      
      if success{
        for item in response.value(forKey: "data") as! Array<Any>{
          let dict: NSDictionary = item as! NSDictionary
          print(dict)
          
          self.cat  = Category()
          self.cat.setDataFromServer(dict: dict)
          self.arrayOffer_delivery.append(self.cat)
          
        }
      }else{
        print("Failed")
      }
      if self.selectedCategory == "delivery"{
        self.nextScene.array_list = self.arrayOffer_delivery
        self.nextScene.tableview_category.reloadData()
      }
      
    }
  }
  
  func fetchHomeMonthly(categoryType : String, categoryType2: String){
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.getHomeService(cat: categoryType, cat2: categoryType2) {
      (success, response) in
      
      if success{
        for item in response.value(forKey: "data") as! Array<Any>{
          let dict: NSDictionary = item as! NSDictionary
          print(dict)
          
          self.cat  = Category()
          self.cat.setDataFromServer(dict: dict)
          self.arrayOffer_monthly.append(self.cat)
        }
        
      }else{
        print("Failed")
        
      }
      if self.selectedCategory == "monthly" {
        self.nextScene.array_list = self.arrayOffer_monthly
      }
    }
  }
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		if #available(iOS 13.0, *) {
			return .darkContent
		} else {
			// Fallback on earlier versions
			return .lightContent
		}
	}
  
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    if segue.identifier == "sw_detailmap" {
      nextScene = segue.destination as! ItemListingMapViewController
    }
  }
}

extension RootListMapViewController : UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    let height: CGFloat = 40// 40
    var width: CGFloat = 200
    
    //we are just measuring height so we add a padding constant to give the label some room to breathe!
    let padding: CGFloat = 40
    
    //estimate each cell's height
    if let text = array_nav[indexPath.row] as? String  {
      width = estimateFrameForText(text: text).width + padding
    }
    
    return CGSize(width: width, height: height)
    
  }
  
  private func estimateFrameForText(text: String) -> CGRect {
    //we make the height arbitrarily large so we don't undershoot height in calculation
    let width: CGFloat = 350
    
    let size = CGSize(width: width, height: 20)
    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
	let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.light)]
    
    return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return array_nav.count
  }
	
	
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailListCollectionViewCell", for: indexPath) as! DetailListCollectionViewCell
    cell.label_headertitle.text = array_nav[indexPath.row]
    
    if self.selectedCategory == "monthly" && indexPath.row == array_nav.count - 1{
      cell.view_bottombar.isHidden = true
    }
    else if self.selectedCategory == "all" && (indexPath.row == 0) {
      cell.view_bottombar.isHidden = true
    }
    else if self.selectedCategory == "new" && indexPath.row == 1{
      cell.view_bottombar.isHidden = true
    }
    else if self.selectedCategory == "delivery" && indexPath.row == 2 {
      cell.view_bottombar.isHidden = true
    }
    else {
      cell.view_bottombar.isHidden = true
    }
	
	if indexPath.row == 2{
		cell.view_bottombar.isHidden = false

	}
    
    
    return cell
  }
}

extension RootListMapViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
	self.dismiss(animated: true, completion: nil)
    /*if indexPath.row == 0 {
      self.nextScene.array_list = arrayOffer_all
      self.selectedCategory = "all"
      print("array offer: \(arrayOffer_all)")
    }else if indexPath.row == 1 {
      self.nextScene.array_list = arrayOffer_new
      self.selectedCategory = "new"
      print("array new: \(arrayOffer_new)")
      
    }else if indexPath.row == 2 {
      self.nextScene.array_list = arrayOffer_delivery
      self.selectedCategory = "delivery"
      print("array Delivery: \(arrayOffer_delivery)")
      
    }else if indexPath.row == 3 {
      self.selectedCategory = "monthly"
      self.nextScene.array_list = arrayOffer_monthly
      print("array Monthly: \(arrayOffer_monthly)")
      
    }
    
    
    if User.getViewName() == "List"{
      self.nextScene.findDistance()
      self.nextScene.tableview_category.reloadData()
    }else{
      self.nextScene.showMap()
    }
    let cell = collectionView.cellForItem(at: indexPath) as! DetailListCollectionViewCell
    for cell in collectionView.visibleCells as! [DetailListCollectionViewCell] {
      cell.view_bottombar.isHidden = true
    }
    
    cell.view_bottombar.isHidden = false
    //    fetchHome(categoryType: type, categoryType2:argumentToServer)*/
  }
}

