//
//  Bootstraper.swift
//  Vouch365
//
//  Created by Veer Suthar on 4/27/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import Foundation
import UIKit
//import HockeySDK

public struct Bootstrapper {
	
	var window : UIWindow
	static var instance : Bootstrapper? = nil
	
	private static func initializeHockey() {
		/*let manager = BITHockeyManager.shared()
		manager.configure(withIdentifier: "703b2f73aaca4a7082f3d7ca47cd80a0")
		manager.crashManager.crashManagerStatus = .autoSend
		manager.start()*/
	}
	
	
	
	public static func initializeWithParam(unique_param: String, token: String){
		validateCredentials(unique_param: unique_param, token: token)
	}
	
	static func initialize() {
		
		//initializeHockey()
		
		#if ENV_DEV
		VolumeChangeListener.setHandler(forPresses: 3, {
			instance!.changeEnv()
		})
		#endif
		
		instance = Bootstrapper(window: makeNewWindow())
		
	}
	
	
	/*static func initialize() {
	
	initializeHockey()
	
	#if ENV_DEV
	VolumeChangeListener.setHandler(forPresses: 3, {
	instance!.changeEnv()
	})
	#endif
	
	instance = Bootstrapper(window: makeNewWindow())
	instance!.bootstrap()
	
	
	Thread.sleep(forTimeInterval: 1)
	}*/
	
	
	#if ENV_DEV
	private func changeEnv() {
		let currentEnv = NetworkEnvironmentProvider.environment
		let alert = UIAlertController(title: "Environment change",
									  message: "Would you like to change current \(currentEnv.toString().uppercased()) to:",
			preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "DEV", style: .default, handler: { [unowned alert] _ in
			if currentEnv == .dev {
				self.displayYourEnvironmentIsTheSame()
			}
			else {
				NetworkEnvironmentProvider.environment = .dev
				let state = CoreAssembler.resolver.resolve(AppStateService.self)!
				state.reset()
				abort()
			}
			alert.dismiss(animated: true, completion: nil)
		}))
		alert.addAction(UIAlertAction(title: "STAGING", style: .default, handler: { [unowned alert] _ in
			if currentEnv == .staging {
				self.displayYourEnvironmentIsTheSame()
			}
			else {
				NetworkEnvironmentProvider.environment = .staging
				let state = CoreAssembler.resolver.resolve(AppStateService.self)!
				state.reset()
				abort()
			}
			alert.dismiss(animated: true, completion: nil)
		}))
		window.rootViewController?.present(alert, animated: true, completion: nil)
	}
	
	private func displayYourEnvironmentIsTheSame() {
		window.makeToast("Your current environment the same!!!")
	}
	#endif
	
	static func reset() {
		User.setUserID(user_ID: "1")
		User.setUserEmail(email: "")
		User.setFirstName(userName: "")
		User.setLastName(userName: "")
		User.setGender(userName: "")
		User.setUserSessionID(session: "")
		User.setPinCode(pin_code: "")
		
		let win = instance!.window
		instance!.window = makeNewWindow()
		instance!.bootstrap()
		
		win.rootViewController = nil
		win.removeFromSuperview()
		
	}
	
	static func showLogin() {
		instance!.showLogin()
	}
	
	static func showHome() {
		instance!.showHome()
	}
	
	static func initializeAfterLoading() {
		instance!.bootstrapAfterLoading()
	}
	
	private static func makeNewWindow() -> UIWindow {
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.backgroundColor = UIColor.white
		
		/*if let del = UIApplication.shared.delegate {
			(del as! AppDelegate).window = window
		}*/
		
		return window
	}
	
	mutating func bootstrap() {
		
		showInitialViewController()
		window.makeKeyAndVisible()
	}
	
	mutating func bootstrapAfterLoading() {
		
		if User.getUserID() ==  "1"{
			showLogin()
		}
		else{
			showHome()
		}
		
		/* if User.getPinCode().count > 0 {
		showHome()
		}else {
		showLogin()
		}*/
		
		window.makeKeyAndVisible()
	}
	
	
	private init(window: UIWindow) {
		self.window = window
	}
	
	static func validateCredentials(unique_param:String,token:String) {
		
		let requestObject: NSDictionary = ["unique_param":unique_param,"token":token]
		ServiceWrapper.jazzSdkCall(requestObject: requestObject) {
			(success, response) in
			if success == false{
				if let viewController = UIStoryboard(name: "Main-Pso", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? UIViewController {
				}
				//instance = Bootstrapper(window: makeNewWindow())
				//instance!.bootstrap()
				//Thread.sleep(forTimeInterval: 1)
				
			}
		}
		
	}
	
	private func showInitialViewController() {
		if let viewController = UIStoryboard(name: "Login-Pso", bundle: nil).instantiateViewController(withIdentifier: "LoaderViewController") as? LoaderViewController {
			self.window.rootViewController = viewController
		}
	}
	
	private func showLogin() {
		
		if let viewController = UIStoryboard(name: "Login-Pso", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController {
			self.window.rootViewController = viewController
		}
		//        if let viewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as? RootViewController {
		//          self.window.rootViewController = viewController
		//        }
		
		
		
	}
	
	private func showHome() {
		
		if let viewController = UIStoryboard(name: "Main-Pso", bundle: nil).instantiateViewController(withIdentifier: "TabBarController") as? UIViewController {
			self.window.rootViewController = viewController
		}
		
	}
}

