//
//  AppDelegate.swift
//  Radar13Jun2017
//
//  Created by Daniel Loewenherz on 6/13/17.
//  Copyright © 2017 Lionheart Software LLC. All rights reserved.
//

import UIKit
import HealthKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let screen = UIScreen.main
        let theWindow = UIWindow(frame: screen.bounds)
        let navigation = UINavigationController(rootViewController: ViewController())
        theWindow.rootViewController = navigation
        theWindow.makeKeyAndVisible()
        window = theWindow
        return true
    }
}
