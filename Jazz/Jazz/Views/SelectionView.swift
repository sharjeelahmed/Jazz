//
//  SelectionView.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/24/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit


protocol SelectionViewDelegate:class {
  func setCityName(name: String)
  func removeSelectionView()
}

class SelectionView: UIView, SelectionCellDelegate {
  
  weak var selectionViewDelegate: SelectionViewDelegate?
  var cities = StorageService.getCitiies()
      
  @IBOutlet weak var tableview_selection: UITableView!
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    tableview_selection.register(SelectionTableViewCell.self, forCellReuseIdentifier: "SelectionTableViewCell")
    
    
    let nibName = UINib(nibName: "SelectionTableViewCell", bundle: nil)
    self.tableview_selection.register(nibName, forCellReuseIdentifier: "SelectionTableViewCell")
    
  }
  
  
  @IBAction func tapOnDone(_ sender: UIButton) {
    print("Welcome")
  }
  
  @IBAction func didTapOnDone(_ sender: UIButton) {
    
    
    
    print("Done is pressed")
    
    
    selectionViewDelegate?.removeSelectionView()
    
  }
  
  class func instanceFromNib() -> UIView {
    return UINib(nibName: "SelectionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
  }
}

extension SelectionView : UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
}

extension SelectionView : UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cities.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "SelectionTableViewCell") as! SelectionTableViewCell
    
    let city = cities [indexPath.row]
    
    if let tag = User.getSelectedBtn() as? Int{
      if tag == indexPath.row {
        cell.button_tick.setImage(UIImage(named: "tick"), for: .normal)
      }else{
        cell.button_tick.setImage(UIImage(named: "blackCross"), for: .normal)
      }
    }else{
      cell.button_tick.setImage(UIImage(named: "blackCross"), for: .normal)
    }
    
    let icon = URL(string: "\(city.icon)")
    cell.image_cityIcon.kf.setImage(with: icon)
    
    cell.button_tick.tag = indexPath.row
    
    cell.label_name.text = cities[indexPath.row].name.capitalizingFirstLetter()
    //cell.label_name.backgroundColor = UIColor.black
    cell.selectionDelegate = self
    return cell
    
  }
  
  func didTapTick(index: Int) {
    
    User.setSelectedBtn(tag: index)
    tableview_selection.reloadData()
    
    let city = cities [index]
    User.setCityName(city: city.name)
    
    selectionViewDelegate?.setCityName(name:cities[index].name.capitalizingFirstLetter())
  }
}
