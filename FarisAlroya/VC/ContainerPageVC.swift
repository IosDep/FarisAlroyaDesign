//
//  ContainerPageVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 04/12/2023.
//

import UIKit

class ContainerPageVC: UIPageViewController , UIPageViewControllerDelegate , UIPageViewControllerDataSource {
    
    var containersVC = [UIViewController]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white

        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "MainPage") as? MainPage
        
       let vc2 = self.storyboard?.instantiateViewController(withIdentifier: "LiveVC") as? LiveVC
        
        containersVC.append(vc1!)
        containersVC.append(vc2!)
        
        delegate = self
        dataSource = self
        
        if let firstVC = containersVC.first {
            
            setViewControllers([firstVC], direction: .forward, animated: true)
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


//let currentIndex = containersVC.firstIndex(of: viewController)
//
//if currentIndex == 0 {
//    return containersVC[1]
//
//}
//
//else {
//    return containersVC[1]
//
//}


//        guard let currentIndex = containersVC.firstIndex(of: viewController) else {
//            return nil
//        }
//
//        let previousIndex = currentIndex - 1
//
//        guard previousIndex >= 0 else {
//            return nil
//        }
        
        
