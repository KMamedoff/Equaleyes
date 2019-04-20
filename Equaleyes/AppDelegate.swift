//
//  AppDelegate.swift
//  Equaleyes
//
//  Created by Kenan Mamedoff on 15/04/2019.
//  Copyright © 2019 Kenan Mamedoff. All rights reserved.
//

import UIKit
import Kingfisher
enum Environment: String {
    case production
    case development
}

var environment: Environment = .development

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        selectAppEnvironment()
        
        #warning("REMOVE THIS")
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache { print("Done") }
        
        return true
    }
    
    fileprivate func selectAppEnvironment() {
        #if DEVELOPMENT
        environment = .development
        #else
        environment = .production
        #endif
    }
    
}

