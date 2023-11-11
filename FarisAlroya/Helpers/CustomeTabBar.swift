//
//  TabBarVC.swift
//  Paradise
//
//  Created by Omar Warrayat on 15/03/2021.
//

import UIKit

class TabBarVC: UITabBarController {
    
    
    var window : UIWindow?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tabBar.unselectedItemTintColor =  UIColor(red: 0.01, green: 0.35, blue: 0.19, alpha: 1.00)



        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = .white

            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
        } else {
            UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
            UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal)
            tabBar.barTintColor = .white

        }
        
                

        
               
        
    }

    
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        
        
            

            
            
            
        }
        
        
        
        
      
    
}
