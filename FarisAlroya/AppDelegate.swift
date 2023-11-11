//
//  AppDelegate.swift
//  FarisAlroya
//
//  Created by Blue Ray on 08/11/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
        
        
        return true
    }


    
    func isLogin() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TabBarVC")
        self.window?.rootViewController = vc
    }
    
    func notLogin() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Loginvc")
        self.window?.rootViewController = vc
    }
    
    
    func creteAccont() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PersonalInfoVC")
        self.window?.rootViewController = vc
    }

}

