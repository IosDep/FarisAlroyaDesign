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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let vc1 = storyBoard.instantiateViewController(withIdentifier: "ْUserFollowListVC") as? ْUserFollowListVC
        
        vc1?.flag = 1
        
       let vc2 = storyBoard.instantiateViewController(withIdentifier: "ْUserFollowListVC") as? ْUserFollowListVC
        
        vc2?.flag = 2
        
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
