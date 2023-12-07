import UIKit
class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setupMiddeleBtn()

    }
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        let middleIndex = 2 // 0-based index for the middle item
//
//        if tabBarController.viewControllers?.index(of: viewController) == middleIndex {
////            showPopup()
//            return false  // Do not select the tab
//        }
//
//        return true  // Allow other tab selections
//    }
    
    @objc func showPopup() {
//        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "OrdersVC") as! OrdersVC
//
//        self.modalPresentationStyle = .overFullScreen
//        self.present(vc, animated: true)
    }
    func setupMiddeleBtn(){
        let middelBtn=UIButton(frame: CGRect(x: (self.view.bounds.width/2)-35, y: -30, width: 65, height: 65))

        middelBtn.setBackgroundImage(UIImage(named: "play-button"), for: .normal)
        middelBtn.layer.shadowColor=UIColor.black.cgColor
        middelBtn.layer.shadowOpacity=0.1
        middelBtn.layer.shadowOffset = CGSize(width: 4, height: 4)



        self.tabBar.addSubview(middelBtn)
        middelBtn.addTarget(self, action: #selector(showPopup), for: .touchUpInside)

       
        self.view.layoutIfNeeded()

    }
}
