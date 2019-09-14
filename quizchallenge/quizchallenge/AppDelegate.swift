//
//  AppDelegate.swift
//  quizchallenge
//
//  Created by alessandra.l.pereira on 13/09/19.
//  Copyright © 2019 alnp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let networkManager = NetworkManager()
        let appStartVC = ViewController(networkManager: networkManager)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = appStartVC
        self.window?.makeKeyAndVisible()
        return true
    }
}

