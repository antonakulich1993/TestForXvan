//
//  AppDelegate.swift
//  TestForXvan
//
//  Created by MacBook on 31.12.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: LocationsViewController())
        window?.makeKeyAndVisible()
        return true
    }
}

