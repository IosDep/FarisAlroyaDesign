//
//  LivePopUpVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 05/12/2023.
//

import UIKit
//import SendbirdUIKit
//import SendbirdLiveUIKit
class LivePopUpVC: UIViewController {
    
    

    @IBOutlet var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        VideoPlayerController.sharedVideoPlayer.pauseCurrentVideo()


    }
    
    
    

    @IBAction func dimsiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let location = touch.location(in: self.view)
//
//            // Check if the location of the touch is outside the mainView
//            if !mainView.frame.contains(location) {
//                self.dismiss(animated: true, completion: nil)
//            }
//        }
//    }


    @IBAction func uplaodeVideo(_ sender: Any) {
        
        
//        self.dismiss(animated: true,completion: {
//         
//        })
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "UplVid") as? UplVid
                vc?.modalPresentationStyle = .overCurrentContext
        self.present(vc!, animated: true)
        
    }
    
    @IBAction func createLive(_ sender: Any) {
        
        
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "LiveStreamListVC") as? LiveStreamListVC
                vc?.modalPresentationStyle = .overCurrentContext
        self.present(vc!, animated: true)
        
    }
    @IBAction func dismiss(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
}
