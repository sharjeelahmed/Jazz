//
//  FullScreenPopUpViewController.swift
//  Vouch365
//
//  Created by Shairjeel Ahmed on 20/10/2019.
//  Copyright © 2019 Veer Suthar. All rights reserved.
//

import UIKit

class FullScreenPopUpViewController: UIViewController {
	
	class func instantiateFromStoryboard() -> FullScreenPopUpViewController {
		  return UIStoryboard(name: "Main-Pso", bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as! FullScreenPopUpViewController
	  }
	
	@IBOutlet weak var imageView:UIImageView!
	var popupModel:PopUP?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		if let imageUrl = self.popupModel?.image{
			let urlStr = Constants.baseUrlStagging + "/" + imageUrl
			let url = URL(string: urlStr)
			imageView.kf.setImage(with: url)
		}
		 
    }
	
	@IBAction func crossBtnPressed(_ sender:UIButton){
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func imageViewBtnPressed(_ sender:UIButton){
		guard let webURl =  popupModel?.url else {return}
		guard let url = URL(string: webURl) else { return }
		UIApplication.shared.open(url)
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
