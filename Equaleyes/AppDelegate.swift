//
//  AppDelegate.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 15/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit

enum Environment: String {
    case production
    case development
}

var environment: Environment = .production

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if DEVELOPMENT
        environment = .development
        #else
        environment = .production
        #endif
        print(environment)
        
        return true
    }
    
}

