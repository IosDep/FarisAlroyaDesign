//
//  ContainerProfileVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 05/12/2023.
//

import UIKit

class ContainerFollowListVC: UIPageViewController , UIPageViewControllerDelegate , UIPageViewControllerDataSource  {
    
    var containersVC = [UIViewController]()
    var flag : Int?
    var target_uid = ""
var commingFromUserOrProfile =  0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        
        let backButton = UIBarButtonItem()
         backButton.title = "رجوع" // Set your custom title
         self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "ْUserFollowListVC") as? ْUserFollowListVC
        
        vc1?.flag = 1
        vc1?.target_uid = target_uid

        vc1?.commingFromUserOrProfile = commingFromUserOrProfile
       let vc2 = storyBoard.instantiateViewController(withIdentifier: "ْUserFollowListVC") as? ْUserFollowListVC
        
        vc2?.flag = 2
        vc2?.target_uid = target_uid
        vc2?.commingFromUserOrProfile = commingFromUserOrProfile

        containersVC.append(vc1!)
        containersVC.append(vc2!)
        
        delegate = self
        dataSource = self
        
        if flag == 1 {
            setViewControllers([containersVC[0]], direction: .forward, animated: true)
        }
        
        else {
            setViewControllers([containersVC[1]], direction: .forward, animated: true)
        }

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = containersVC.firstIndex(of: viewController) else {
                return nil
            }

            let previousIndex = currentIndex - 1

            // Check if the previous index is within the bounds of the array
            guard previousIndex >= 0 else {
                return nil
            }

            return containersVC[previousIndex]

        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = containersVC.firstIndex(of: viewController) else {
                return nil
            }

            let nextIndex = currentIndex + 1

            // Check if the next index is within the bounds of the array
            guard nextIndex < containersVC.count else {
                return nil
            }

            return containersVC[nextIndex]
        
    }
    
    

   

}
