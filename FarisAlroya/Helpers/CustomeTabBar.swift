import Foundation
import UIKit



class CustomeTabBar: UITabBarController, UITabBarControllerDelegate {
    
    let thirdTabBarItemIndex = 2


    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = .white
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
            
            tabBar.standardAppearance = tabBarAppearance
            tabBar.scrollEdgeAppearance = tabBarAppearance
            
        } else {
            UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
            UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.lightGray], for: .normal) 
            tabBar.barTintColor = .white
        }
        
        
        if let thirdTabBarItem = tabBar.items?[2] {
                let selectedAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.blue]
                let normalAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.white]
             
                thirdTabBarItem.setTitleTextAttributes(normalAttributes, for: .normal)
            }
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // Check if the selected view controller corresponds to the third tab bar item
        if let index = tabBarController.viewControllers?.firstIndex(of: viewController), index == thirdTabBarItemIndex {
            // Present your view controller modally (like a sheet)
            if let livePopupViewController = storyboard?.instantiateViewController(withIdentifier: "LivePopUpVC") as? LivePopUpVC {
                present(livePopupViewController, animated: false, completion: nil)
                return false
            }
        }
        return true // Allow default behavior for other items
    }
}
