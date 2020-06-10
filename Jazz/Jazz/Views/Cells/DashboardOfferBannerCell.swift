//
//  DashboardOfferBannerCell.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/19/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

protocol DashboardOfferBannerCellDelegate: class {
  func didSelectIndexAtBanner(index: Voucher)
}

class DashboardOfferBannerCell : UITableViewCell {
  
  @IBOutlet weak var collectionView: UICollectionView!
  weak var delegate:DashboardOfferBannerCellDelegate?
  var array_collection: Array <Voucher> = Array()
  
  @IBOutlet weak var label_title: UILabel!
  @IBOutlet weak var imageView_happily: UIImageView!

  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
	
	Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)

	
	
  }
	
	@objc func scrollAutomatically(_ timer1: Timer) {
		   
		   if let coll  = collectionView {
			   for cell in coll.visibleCells {
				   let indexPath: IndexPath? = coll.indexPath(for: cell)
				if ((indexPath?.row)!  < self.array_collection.count - 1){
					   let indexPath1: IndexPath?
					   indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
					   
					   coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
				   }
				   else{
					   let indexPath1: IndexPath?
					   indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
					   coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
				   }
				   
			   }
		   }
		   
	   }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
}

extension DashboardOfferBannerCell : UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("Load cell for row \(array_collection)")
    return array_collection.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
    let voucher : Voucher = array_collection[indexPath.row]
    
    print("voucher : ",voucher)
    
    let url_banner = URL(string: "\(Constants.baseUrlStagging)/\(voucher.header!)")
    
    if url_banner != nil {
      
      print("banner image \(String(describing: url_banner))")
      cell.imageview_banner.kf.setImage(with: url_banner!)
    }
    
    let url_logo = URL(string: "\(Constants.baseUrlStagging)/\(voucher.logo!)")

    if url_logo != nil {
      print( "image logo: ",url_logo!)
      cell.imageview_logo.kf.setImage(with: url_logo)
    }
    
    let label_text = voucher.tag!
    cell.label_title.text = label_text
    
    return cell
  }
  
}

extension DashboardOfferBannerCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("INdex Path in collectionView \(indexPath.row)")
    delegate?.didSelectIndexAtBanner(index: array_collection[indexPath.row])
  }
 
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    
    // Ensure the scrollview is the one on the collectionView we care are working with
    if (scrollView == self.collectionView) {
      
      // Find cell closest to the frame centre with reference from the targetContentOffset.
      let frameCenter: CGPoint = self.collectionView.center
      var targetOffsetToCenter: CGPoint = CGPoint(x: targetContentOffset.pointee.x + frameCenter.x, y: targetContentOffset.pointee.y + frameCenter.y)
      var indexPath: IndexPath? = self.collectionView.indexPathForItem(at: targetOffsetToCenter)
      
      // Check for "edge case" where the target will land right between cells and then next neighbor to prevent scrolling to index {0,0}.
      while indexPath == nil {
        targetOffsetToCenter.x += 10
        indexPath = self.collectionView.indexPathForItem(at: targetOffsetToCenter)
      }
      // safe unwrap to make sure we found a valid index path
      if let index = indexPath {
        // Find the centre of the target cell
        if let centerCellPoint: CGPoint = collectionView.layoutAttributesForItem(at: index)?.center {
          
          // Calculate the desired scrollview offset with reference to desired target cell centre.
          let desiredOffset: CGPoint = CGPoint(x: centerCellPoint.x - frameCenter.x, y: centerCellPoint.y - frameCenter.y)
          targetContentOffset.pointee = desiredOffset
        }
      }
    }
  }

  
}
