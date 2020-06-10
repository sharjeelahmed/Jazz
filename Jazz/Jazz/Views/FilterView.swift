//
//  FilterView.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/8/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit


protocol FilterViewDelegate:class {
  func removeFilterView()
}


class FilterView: UIView, FilterCellDelegate {
  
  
  @IBOutlet weak var filterTitle: UILabel!
  @IBOutlet weak var btnDone: UIButton!
  @IBOutlet weak var btnClear: UIButton!
  var categoryStr : String!
  var isClear = false
  weak var filterDelegate: FilterViewDelegate?
  
  var arraySelected: [KeyValue] = []
  var arrayUnselected: [KeyValue] = []
  
  var arrayTitles = ["Alochol", "Brunch","Buffet","Dress Code","Fine Dining","Groups Welcome","Halal","Kids Welcome","Live Entertainment"]
  var arrayTitlesImages = ["alcohol_icon", "Brunch","Buffet","Dress_code_informal","Fine_dining","Groups_welcome","Halal","Kids_welcome","Live_Entertainment"]
  
  var arrayData  : Array<KeyValue> = Array<KeyValue>()//= ["SELECT TYPE ...", "SELECT CUISINE"]
  
  
  @IBOutlet weak var tableview_selection: UITableView!
  
  // Only override draw() if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  
  func setCategory(category: String) {
    self.categoryStr = category
    self.filterTitle.text = category
    if categoryStr ==  "Food & Drinks" {
      arrayData = FiltersArray.foodAndRestaurants()
    }
    else if category == "Salon & Spa" {
        arrayData = FiltersArray.salonAndSpaArray()
    }
    else if category == "Leisure" {
        arrayData = FiltersArray.attractionAndleisure()
    }
    else if category == "Retail & Services"{
        arrayData = FiltersArray.retailAndservinces()
    }
  }
  override func draw(_ rect: CGRect) {
    // Drawing code
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    
    let nibName = UINib(nibName: "FilterCell", bundle: nil)
    self.tableview_selection.register(nibName, forCellReuseIdentifier: "FilterCell")
    
    let nibName2 = UINib(nibName: "FilterSimpleCell", bundle: nil)
    self.tableview_selection.register(nibName2, forCellReuseIdentifier: "FilterSimpleCell")
    customizeView()
    
    
    
    
  }
  
  
  func customizeView(){
    
    btnDone.layer.borderColor = UIColor.white.cgColor
    btnDone.borderWidth = 1
    
    btnClear.layer.borderColor = UIColor.white.cgColor
    btnClear.borderWidth = 1
    
    
  }
  
  
  
  @IBAction func tapOnDone(_ sender: UIButton) {
    print("Welcome")
    filterDelegate?.removeFilterView()
    
    
  }
  
  @IBAction func didTapOnClear(_ sender: Any) {
    print("didTapOnClear")
    
    arrayTitles.removeAll()
    
    arrayTitles = ["Alochol", "Brunch","Buffet","Delivery","Groups Welcome","Halal","Kids Welcome","Live Entertainment"]
    
    tableview_selection.reloadData()
    
  }
  
  
  class func instanceFromNib() -> UIView {
    return UINib(nibName: "SelectionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
  }
}

extension FilterView : UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44
  }
  
  
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0
  }
  
}

extension FilterView : UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    
    return arrayData.count
    
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell") as! FilterCell
    let keyValue = arrayData[indexPath.row]
    
    
    if let foundde = arrayUnselected.index(where: {$0.value == arrayData[indexPath.row].value}){
      cell.btnRight.setImage(UIImage(named: "cros"), for: .normal)
      cell.btnRight.accessibilityIdentifier = "cros"
      print("Founc \(foundde)")
      
    }
    else {
      cell.btnRight.setImage(UIImage(named: "blackCross"), for: .normal)
      cell.btnRight.accessibilityIdentifier = "blackCross"
      
    }
    
    if let founder = arraySelected.index(where: {$0.value == arrayData[indexPath.row].value}){
      cell.btnLeft.setImage(UIImage(named: "tick"), for: .normal)
      cell.btnLeft.accessibilityIdentifier = "tick"
      print("Founc \(founder)")
      
    }
    else {
      cell.btnLeft.setImage(UIImage(named: "blackTick"), for: .normal)
      cell.btnLeft.accessibilityIdentifier = "blackTick"
    }
    
    
    if isClear{
      cell.btnLeft.setImage(UIImage(named: "blackTick"), for: .normal)
      cell.btnLeft.accessibilityIdentifier = "blackTick"
      cell.btnLeft.setImage(UIImage(named: "blackCross"), for: .normal)
      cell.btnRight.accessibilityIdentifier = "blackCross"
      isClear = false
    }
    
    cell.lblFilter.text = keyValue.value
    cell.imageFilterCell.image = keyValue.image
    
    
    cell.filterCellDelegate = self
    cell.btnRight.tag = indexPath.row
    cell.btnLeft.tag = indexPath.row
    return cell
    
    
    
    
    
  }
  
  
  
  
  
  func didTapTick(index: Int, name: String) {
    
    if name == "selected"{
      arraySelected.append(arrayData[index])
      
      if let foundd = arrayUnselected.index(where: {$0.value == arrayData[index].value}){
        arrayUnselected.remove(at: foundd)
      }
      print("selected",arraySelected)
      print("unselected",arrayUnselected)
      
    }else{
      
      arrayUnselected.append(arrayData[index])
      
      if let foundd = arraySelected.index(where: {$0.value == arrayData[index].value}){
        arraySelected.remove(at: foundd)
      }
      
      print("selected",arraySelected)
      print("unselected",arrayUnselected)
    }
    
    
  }
}
