//
//  HomeContainerVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 04/12/2023.
//

import UIKit
import Tabman
import Pageboy

class HomeContainerVC: TabmanViewController ,  PageboyViewControllerDataSource, TMBarDataSource {
    
   
    var viewControllers: [UIViewController] = [
           Loginvc(),
           FollowListVC(),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap // Customize
    
        addBar(bar, dataSource: self, at: .top)
        
//        bar.buttons.customize { (button) in
//            button.tintColor =  
//            button.selectedTintColor = .red
//        }
    

    }
    
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        
        return viewControllers[index]
     
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        
            return nil
            
       
    }
    
    
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        
        let title = "Page \(index)"
                
        return TMBarItem(title: title)
        
    }
    
    
    
    

}
