//
//  AppDelegate.swift
//  LaundryLad
//
//  Created by Stephen Ma on 1/2/20.
//  Copyright © 2020 Stephen Ma. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyALJBtxq2QRzzdHlpHwXz8A2pejsnY9dCg")
        FirebaseApp.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        var navigationController: UINavigationController? = (self.window?.rootViewController as? UINavigationController)
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if Auth.auth().currentUser != nil {
            print("run 1")
            // Set Your home view controller Here as root View Controller
            let viewController = storyboard.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
            let navigationController = UINavigationController(rootViewController: viewController)
            self.window?.rootViewController = navigationController
            self.window!.makeKeyAndVisible()
        } else {
            print("run 2")
            // Set you login view controller here as root view controller
            let viewController = storyboard.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
            let navigationController = UINavigationController(rootViewController: viewController)
            self.window?.rootViewController = navigationController
            self.window!.makeKeyAndVisible()
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    //MARK: Private Methods
    private func setRootViewController() {

    }

}

