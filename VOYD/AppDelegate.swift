//
//  AppDelegate.swift
//  VOYD
//
//  Created by MacBook Pro on 17/10/2022.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let vc : UIViewController?
        
        if UserDefault.userLogingCheck() {
             vc = LoginViewController.instantiate(fromStoryBoards: .Authentication)
        }else {
            vc = ViewController.instantiate(fromStoryBoards: .Main)
        }
        
        let navVC = NavigationController(rootViewController: vc!)
        
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        return true
    }

}

