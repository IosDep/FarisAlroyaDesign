//
//  FollowListVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 04/12/2023.
//

import UIKit
import Lottie

class NotificationsVC: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    let viewModel = MainViewModel()
    var anim: LottieAnimationView!

    @IBOutlet weak var tableView: UITableView!
    
    var list : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.register(UINib(nibName: "FollowListCell", bundle: nil), forCellReuseIdentifier: "FollowListCell")
        VideoPlayerController.sharedVideoPlayer.pauseCurrentVideo()

        
        tableView.register(UINib(nibName: "NotificationsHeader", bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: "NotificationsHeader")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        anim = LottieAnimationView(name: "watings") // Replace "animationName" with your animation file's name

           // Set the frame or use Auto Layout constraints
           anim.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
           anim.center = self.view.center

           // Configure animation properties
           
           anim.loopMode = .loop

           // Add it to your view
           self.view.addSubview(anim)

           // Start playing the animation
           anim.play()
        
        
        getNotifcation()

    }
    
    
    @IBAction func notificationSettingPressed(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "NotificationPopupVC") as? NotificationPopupVC
        
            present(vc!, animated: false, completion: nil)
            
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//       return 3
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.notifcaitonArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FollowListCell", for: indexPath) as? FollowListCell
        let data  = self.viewModel.notifcaitonArray[indexPath.row]
        cell?.username.text = data.body ?? ""
        return cell!
                
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
        
    }
    
    
    private func getNotifcation() {
        
        viewModel.getNotifcation(){ [weak self] hasMoreData, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Handle error
                    print("Error:", error.localizedDescription)
                    return
                }
                self?.anim.stop()
                self?.tableView?.reloadData()
            }
            if ((self?.viewModel.videos.isEmpty) != nil) {
                self?.anim.isHidden = true
                self?.anim.stop()


            }else {
                self?.anim.isHidden = false

            }
        }
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NotificationsHeader") as? NotificationsHeader
//
//        return headerView
//    }

//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//
//        return 35
//    }
   
}
