//
//  AppDelegate.swift
//  Calculator
//
//  Created by Anna Belousova on 25.05.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = CalculatorViewController()
		window?.makeKeyAndVisible()
		return true
	}
}

