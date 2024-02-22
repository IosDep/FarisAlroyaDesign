import UIKit
class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        setupMiddeleBtn()
        VideoPlayerController.sharedVideoPlayer.pauseCurrentVideo()
        self.view.isUserInteractionEnabled = false
           
           // Set a delay for 5 seconds
           let delayInSeconds = 5.0
           DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) {
               // Re-enable user interaction after 5 seconds
               self.view.isUserInteractionEnabled = true
           }
        
        self.selectedIndex = 4

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
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "LivePopUpVC") as! LivePopUpVC
                
        self.present(vc, animated: true)
        

    }
    func setupMiddeleBtn(){
        let middelBtn=UIButton(frame: CGRect(x: (self.view.bounds.width/2)-35, y: -30, width: 65, height: 110))

        middelBtn.setBackgroundImage(UIImage(named: "discover 1"), for: .normal)
        middelBtn.layer.shadowColor=UIColor.black.cgColor
        middelBtn.layer.shadowOpacity=0.1
        middelBtn.layer.shadowOffset = CGSize(width: 4, height: 4)



        self.tabBar.addSubview(middelBtn)
        middelBtn.addTarget(self, action: #selector(showPopup), for: .touchUpInside)

       
        self.view.layoutIfNeeded()

    }
}
