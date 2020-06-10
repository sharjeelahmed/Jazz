//
//  ViewController.swift
//  Example Project
//
//  Created by Shairjeel Ahmed on 13/01/2020.
//  Copyright © 2020 Shairjeel Ahmed. All rights reserved.
//

import UIKit
import TakafulVouch
 

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	@IBAction func btnPressed(_ sender:UIButton){
		//HomeViewController.instantiateFromStoryboard()
		let vouchMana = VouchManager()
		
		 vouchMana.getVouchNavigaionController(unique_param: "1111111111111",token: "486824320Ab@*/PAK", completionHandler: {success,NavCon,errorDes in
			if success{
				if let nav = NavCon{
					nav.modalPresentationStyle = .fullScreen
					self.present(nav, animated: true, completion: nil)
				}
			}else{
				print(errorDes)
			}
			
		}
		)
		
		//HomeVc.modalPresentationStyle = .fullScreen
		//self.present(HomeVc, animated: true, completion: nil)
		//self.present(HomeVc, animated: true, completion: nil)
		
		//VouchManager.instantiateFromStoryboard()
		
		//Bootstrapper.initializeWithParam(unique_param: "03124578451", token: "1#Jf@dJ3%e8O}qQYs{DS")
	}


}

