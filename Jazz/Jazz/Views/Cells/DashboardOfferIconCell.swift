//
//  DashboardOfferIconCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/19/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit

protocol DashboardOfferIconCellDelegate: class {
  func didSelectIndexAtIcon(index: Int)
}

class DashboardOfferIconCell : UITableViewCell {
  @IBOutlet weak var collectionView: UICollectionView!
  weak var delegate:DashboardOfferIconCellDelegate?
  
  var array_cat = ["Food & Drinks","Salon & Spa","Leisure","Health Care","Retail & Services","Travel"]
  var array_images = ["icon_food","icon_saloon","icon_leisure","icon_health","icon_service","icon_travel"]
  
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    // code common to all your cells goes here
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    
    
  }
}

extension DashboardOfferIconCell : UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return array_cat.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCollectionViewCell", for: indexPath) as! IconCollectionViewCell
    
    cell.imageView.image = UIImage(named:array_images[indexPath.row])
    cell.label_category.text = array_cat[indexPath.row].uppercased()
    
  return cell
  }
}

extension DashboardOfferIconCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("INdex Path in collectionView \(indexPath.row)")
      delegate?.didSelectIndexAtIcon(index: indexPath.row)
  }
  
}

extension DashboardOfferIconCell: UICollectionViewDelegateFlowLayout{
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    

    let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
    let totalSpace = flowLayout.sectionInset.left
      + flowLayout.sectionInset.right
      + (flowLayout.minimumInteritemSpacing * CGFloat(1 - 1))
   
    
    let height = Utilities.convertIphone6ToIphone5(size: 80)

    let width = height/2

    let size = (width - totalSpace) / CGFloat(1)
    
    return CGSize(width: size, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
  {
	return   UIEdgeInsets(top: 0, left: Utilities.convertIphone6ToIphone5_Width(size: 15) , bottom: 0,  right: Utilities.convertIphone6ToIphone5_Width(size: 15))

  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
  {
      Utilities.convertIphone6ToIphone5_Width(size: 18)
  }
  
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
 {
     Utilities.convertIphone6ToIphone5_Width(size: 18)

  }

  
}
