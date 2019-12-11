//
//  AppDelegate.swift
//  Lab1
//
//  Created by Liubomyr on 9/19/19.
//  Copyright © 2019 Liubomyr. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
final class  AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK:  Variables
    var window: UIWindow?
    
    //MARK:  Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

}

