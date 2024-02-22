//
//  UIApplication+EX.swift
//  CARDIZERR
//
//  Created by Osama Abu hdba on 28/08/2022.
//

import Foundation
import UIKit
extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

extension UIApplication {
    static func topMostController() -> UIViewController {
        guard var topController = UIApplication.shared.keyWindow?.rootViewController else {
            return UIViewController()
        }
        while topController.presentedViewController != nil {
            topController = topController.presentedViewController!
        }
        return topController
    }

    static func topViewController(base: UIViewController? = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
