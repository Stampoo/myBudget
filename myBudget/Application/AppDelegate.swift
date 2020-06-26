//
//  AppDelegate.swift
//  myBudget
//
//  Created by fivecoil on 25/06/2020.
//  Copyright © 2020 fivecoil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let scoreViewController = ScoreConfigurator().configureModule()
        let navigationController = UINavigationController(rootViewController: scoreViewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

}

