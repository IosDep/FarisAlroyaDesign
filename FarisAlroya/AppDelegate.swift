//
//  AppDelegate.swift
//  FarisAlroya
//
//  Created by Blue Ray on 08/11/2023.
//

import UIKit
import MOLH

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        MOLHLanguage.setDefaultLanguage("ar")
//        MOLH.shared.activate(false)

        if ((Helper.shared.getId()?.isEmpty) != nil){
//            isLogin()
        }else {
//            notLogin()
        }
        
        return true
    }


    
    func isLogin() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CustomeTabBar")
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

