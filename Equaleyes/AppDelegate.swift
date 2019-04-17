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

var environment: Environment = .development

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        selectProductionEnvironment()
        
        return true
    }
    
    private func selectProductionEnvironment() {
        #if DEVELOPMENT
        environment = .development
        #else
        environment = .production
        #endif
    }
    
}

