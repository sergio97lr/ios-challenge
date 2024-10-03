//
//  AppDelegate.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let splashtRouter = SplashRouter()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = splashtRouter.view
        window?.makeKeyAndVisible()
        
        
        return true
    }


}
