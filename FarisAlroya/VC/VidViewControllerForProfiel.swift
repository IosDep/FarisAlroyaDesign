//
//  ViewController.swift
//  TikTok Video Feed Swift
//
//  Created by Cedan Misquith on 19/10/22.
//

import UIKit
import Lottie
import JGProgressHUD
import Alamofire
class VidViewControllerForProfiel: UIViewController {
    @IBOutlet weak var indecoter: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topGradientImageView: UIImageView!
        var presenter: NewAppendItItems!
        let mainViewModel = MainViewModel()
        var videoData = [NewAppendItItems]()
        var anim: LottieAnimationView!
        var indx:Int = 0
        var page:Int = 5
        var isGust = 0
        var state = 0
        var currentPage = 0
    var postion = 0
    
    @IBOutlet weak var logins: UIButton!
    var userId =  "0"
    var isHome =  0
    var stop_pagention = true
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)

 
    }
    
    var lastPage = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.anim.isHidden = true
            self.currentPage = self.indx
            let indexPath = IndexPath(row: self.postion, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)//            self.tableView.scrollToRow(at: indexpath, at: postion, animated: tr)
            VideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: self.tableView)
            self.indecoter.isHidden = true
        }
        configureGradients()
        configureTableView()
  
        
        if isGust == 0{
            self.logins.isHidden =  true
        }else {
            self.logins.isHidden =  false

        }
        
        self.stop_pagention = true

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appDidEnterBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
        
        print("FGHJK",self.mainViewModel.videos.count)
//        getVideos(indx:indx,load:0)
        
   
        
    }
    @objc func appDidEnterBackground() {
        VideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: self.tableView,flag: 1)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("44")
        VideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: self.tableView,flag: 1)
    }

    fileprivate func configureGradients() {
        let topGradient = Utilities.shared.createGradient(color1: UIColor.black.withAlphaComponent(0.7),
                                         color2: UIColor.black.withAlphaComponent(0.0),
                                         frame: topGradientImageView.bounds)
        
        topGradientImageView.contentMode = .scaleAspectFill
        topGradientImageView.image = topGradient
        
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

    }
    fileprivate func configureTableView() {
        tableView.isPagingEnabled = true
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(UINib(nibName: "VideoCustomCell", bundle: nil),
                           forCellReuseIdentifier: "VideoCustomCell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)

    }
    
    
    @IBAction func loginss(_ sender: Any) {
        Helper.shared.saveUserToken(user_picture: "")

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.notLogin()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? VideoCustomCell {
            cell.togglePlayPause()
            cell.playpayseImage.isHidden = true
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? VideoCustomCell {
            cell.togglePlayPause()
            cell.playpayseImage.isHidden = false
        }
    }

    @objc func savedAction(sender: UIButton) {
      
        if self.videoData[sender.tag].userSave == false {
            self.addRemoveFlagActionSaved(entity_id: videoData[sender.tag].nodeId ,entity_type: "node",flag_id : "save", completionHandler: { (result) in
                if result == true {
                    let indexPath = IndexPath(row: sender.tag, section: 0)
                    let cell  = self.tableView.cellForRow(at: indexPath) as! VideoCustomCell
                    let color1 = UIColor(red: 24/255, green: 163/255, blue: 170/255, alpha: 1)

                    cell.saveBtn.setImage(UIImage(named:  "savefill")?.withTintColor(color1), for: .normal)
                    self.videoData[sender.tag].userSave = true
//                    self.didPullToRefresh()

//                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            })
            
        }else {
            self.addRemoveFlagActionSaved(entity_id: self.videoData[sender.tag].nodeId ,entity_type: "node",flag_id : "save", completionHandler: { (result) in
                if result == true {
                    let indexPath = IndexPath(row: sender.tag, section: 0)
                    let cell  = self.tableView.cellForRow(at: indexPath) as! VideoCustomCell
                    cell.saveBtn.setImage(UIImage(named:  "save"), for: .normal)
                    self.videoData[sender.tag].userSave = false
//                    self.tableView.reloadRows(at: [indexPath], with: .automatic)

//                    self.didPullToRefresh()
                    
                }
            })
            
        }
        
        
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func favouriteAction(sender: UIButton) {
        
        if self.videoData[sender.tag].userFav == false {
            self.addRemoveFlagActionLike(entity_id: self.videoData[sender.tag].nodeId ,entity_type: "node",flag_id : "favorites", completionHandler: { (result) in
                if result == true {
                    let indexPath = IndexPath(row: sender.tag, section: 0)
                    let cell  = self.tableView.cellForRow(at: indexPath) as! VideoCustomCell
                    let color1 = UIColor(red: 24/255, green: 163/255, blue: 170/255, alpha: 1)
                    
                    cell.likeBtn.setImage(UIImage(named:  "star_fill")?.withTintColor(color1), for: .normal)
                    self.videoData[sender.tag].userFav = true
                    let numLike = Int(self.videoData[sender.tag].numofVideoLike ) ?? 0
                    
                    
                        cell.like_counts.text = "\(numLike +  1)"
            

                 
                    //                    self.didPullToRefresh()
//                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                    
                    
                }
            })
            
        }else {
            self.addRemoveFlagActionLike(entity_id: self.videoData[sender.tag].nodeId ,entity_type: "node",flag_id : "favorites", completionHandler: { (result) in
                if result == true {
                    let indexPath = IndexPath(row: sender.tag, section: 0)
                    let cell  = self.tableView.cellForRow(at: indexPath) as! VideoCustomCell
                    cell.likeBtn.setImage(UIImage(named:  "star"), for: .normal)
                    let numLike = Int(self.videoData[sender.tag].numofVideoLike ) ?? 0

//                    if numLike > 0{
//                        cell.like_counts.text = "\(numLike -  1)"
//
//                    }else {
//                        cell.like_counts.text = "\(numLike)"
//
//                    }
                    self.videoData[sender.tag].userFav = false
//                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                    
                    //                    self.didPullToRefresh()
                    
                }
            })
            
        }
        
    }
    
    
    
    @objc func goToUserProfile(sender: UIButton) {
        
        let data = videoData[sender.tag]
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MianVC") as! MianVC

//        vc.modalPresentationStyle =  .fullScreen

        vc.userId = data.userId
        vc.userName = data.userName
        vc.userImageLink = data.userPic
        vc.numOfLike = "\(data.numOfLikes)"
        vc.numOfFollow = "\(data.numOfFollowers)"
        vc.numOfFollowing = "\(data.numOfFollowing)"
        vc.isFollowign =  "\(data.target_user_follow_flag)"
        self.navigationController?.pushViewController(vc, animated: false)
        
        
        
        
    }
    private func getVideos(indx:Int,load:Int) {
        let uid = Helper.shared.getId() ?? ""
        
  
     
        if load == 1 {
            self.indecoter.startAnimating()
            self.indecoter.isHidden = false
            self.anim.stop()
            self.anim.isHidden = true
        } else {
            // Hide the activity indicator when not loading more items
            self.indecoter.stopAnimating()
            self.indecoter.isHidden = true
            
            self.anim.play()
            self.anim.isHidden = false
        }
        
        var stateFromWhree =  ""
        if state == 0 {
            stateFromWhree =  "1"
        }else{
            stateFromWhree =  "0"
        }
        mainViewModel.getMainVideos(uid: self.userId, isHome: "0", state: stateFromWhree, pageSize: self.page , page: self.currentPage) { [weak self] (videos, error) in
      

            DispatchQueue.main.async {
                if let error = error {
                    print("Error:", error.localizedDescription)
                    return
                }


                if !videos.isEmpty {
                    let oldCount = self?.videoData.count ?? 0
                    self?.videoData.append(contentsOf: videos)
                    let newCount = self?.videoData.count ?? 0
                    let indexPaths = (oldCount..<newCount).map { IndexPath(item: $0, section: 0) }
                    self?.stop_pagention = false
                    
                    self?.indecoter.stopAnimating()
                    self?.indecoter.isHidden = true
                    self?.anim.stop()
                    self?.anim.isHidden = true
                    
                    
                    DispatchQueue.main.async {
                        if videos.isEmpty || videos == nil{
                            self?.lastPage = true

                        }

                        self?.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

                        self?.tableView.reloadData()
                        
                        
                        if let firstVisibleIndexPath = self?.tableView.indexPathsForVisibleRows?.first {
                                       self?.playVideoForCellAtIndexPath(firstVisibleIndexPath)
                                   }
                    }
                    self?.indx  = (self?.indx ?? 0) + 1
                    self?.currentPage = (self?.currentPage ?? 1)  + 1
                    
//                    self?.videoColletion.performBatchUpdates({
//                        self?.videoColletion.insertItems(at: indexPaths)
//                    }, completion: { _ in
//                        if let newFirstItemIndex = indexPaths.first {
//                            // Optional: Scroll to the first item of the new data
//                            self?.videoColletion.scrollToItem(at: newFirstItemIndex, at: .top, animated: false)
//                        }
//                    })
                } else {
                    self?.stop_pagention = false

                    self?.mainViewModel.hasMoreData = false
                    self?.anim.isHidden = true
                }
            }
        }
    }
    
    
}
extension VidViewControllerForProfiel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height
        
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//        if self.videoData.count >= 3 {
//        if indexPath.row == self.videoData.count - 3 {
//            getVideos(indx: self.indx)
//            indx += 1
//            self.page =  4
//            print("DATA")
    
    
//            print(indx)
//        }
//        }
//    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.lastPage != true && indexPath.row == self.videoData.count - 4{
            indx += 1
            self.page = 2
            getVideos(indx: self.indx,load:1)
            print("IndexCount",indx)
            print("lastPages",lastPage)

        }
    }

    
    private func playVideoForCellAtIndexPath(_ indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PlayVideoLayerContainer {
            VideoPlayerController.sharedVideoPlayer.playVideo(withLayer: cell.videoLayer, url: cell.videoURL ?? "")
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCustomCell") as? VideoCustomCell else {
            return UITableViewCell()
        }
        cell.configureCell(data: self.videoData[indexPath.row])
        
        cell.more.tag =  indexPath.row
        cell.more.addTarget(self, action: #selector(self.moreAction(sender:)), for: .touchUpInside)

        cell.likeBtn.tag =  indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(self.favouriteAction(sender:)), for: .touchUpInside)
        
        
        
        cell.saveBtn.tag =  indexPath.row
        cell.saveBtn.addTarget(self, action: #selector(self.savedAction(sender:)), for: .touchUpInside)
        
        
        cell.profileBtn.tag =  indexPath.row
        cell.profileBtn.addTarget(self, action: #selector(self.goToUserProfile(sender:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? PlayVideoLayerContainer {
            if videoCell.videoURL != nil {
                VideoPlayerController.sharedVideoPlayer.removeLayerFor(cell: videoCell)
            }
        }
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        VideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tableView)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            VideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tableView)
        }
    }
    
    
    @objc func moreAction(sender: UIButton) {
        
        

        let alertController = UIAlertController(title:"ساعدنا في ادارة المحتوى", message: nil, preferredStyle: .alert)

        
        let action = UIAlertAction(title:"حذف الفيديو الخاص بي" , style: .default, handler: { _ in
            // Handle action 1
            self.removeItem(index: sender.tag,realDele: 1)

        })
        let action1 = UIAlertAction(title:"حظر المستخدم" , style: .default, handler: { _ in
            // Handle action 1
            self.blockUser(sender: sender)
            
            
        })
        let action2 = UIAlertAction(title: "الابلاغ عن المنشور", style: .default, handler: { _ in
            // Handle action 2
            self.reportUser(sender: sender)

        })
        let action3 = UIAlertAction(title: "فلترةالمحتوى", style: .default, handler: { _ in
            // Handle action 3
            self.videoData.removeAll()
            self.getVideos(indx: self.indx  + 1, load: 0)
            self.showErrorHud(msg: "تم فلترة البيانات بناء على تصنيفاتك المفضلة")
            

        })
     
        let cancelAction = UIAlertAction(title: "الغاء", style: .cancel, handler: nil)
        
        if self.state == 1 {
            alertController.addAction(action)

        }

        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        
        alertController.addAction(cancelAction)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view // The view containing the anchor rectangle for the popover.
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // The rectangle in the specified view in which to anchor the popover.
            popoverController.permittedArrowDirections = [] // Optional: Arrow directions for the popover.
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func blockUser(sender: UIButton) {
        let index = sender.tag
        
        let alertController = UIAlertController(title:"حظر مستخدم", message: nil, preferredStyle: .alert)

        let action1 = UIAlertAction(title:"حظر المستخدم لعدم مطابقة الشروط" , style: .default, handler: { _ in
            // Handle action 1
            self.removeItem(index: index)

            self.showErrorHud(msg: "تم حظر المستخدم شكرا لمساهمتك")
        })
        let action2 = UIAlertAction(title: "حظر مستخدم بسبب سوء استعماله للتطبيق", style: .default, handler: { _ in
            self.removeItem(index: index)

            self.showErrorHud(msg: "تم حظر المستخدم شكرا لمساهمتك")
        })
        let action3 = UIAlertAction(title: "حظر مستخدم لاسباب اخرى ", style: .default, handler: { _ in
            self.removeItem(index: index)

            self.showErrorHud(msg: "تم حظر المستخدم شكرا لمساهمتك")
            
            
        })
     
        let cancelAction = UIAlertAction(title: "الغاء", style: .cancel, handler: nil)

        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        
        alertController.addAction(cancelAction)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view // The view containing the anchor rectangle for the popover.
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // The rectangle in the specified view in which to anchor the popover.
            popoverController.permittedArrowDirections = [] // Optional: Arrow directions for the popover.
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func reportUser(sender: UIButton) {
        let index = sender.tag
        

        let alertController = UIAlertController(title:"محتوى غير مرغوب فيه", message: nil, preferredStyle: .alert)

        let action1 = UIAlertAction(title:"محتوى جنسي او مخالف ", style: .default, handler: { _ in

            self.removeItem(index: index)
            self.showErrorHud(msg: "ستتم مراجعة المحتوى وبناء وفلترة محتواك ")

        })
        let action2 = UIAlertAction(title: "محتوى يحتوى على مشاهد عنف وخلوع", style: .default, handler: { _ in
            self.removeItem(index: index)
            self.showErrorHud(msg: "ستتم مراجعة المحتوى وبناء وفلترة محتواك ")
            // Handle action 2
        })
        let action3 = UIAlertAction(title: "محتوى سياسي ", style: .default, handler: { _ in
            self.removeItem(index: index)
            self.showErrorHud(msg: "ستتم مراجعة المحتوى وبناء وفلترة محتواك ")
            
            // Handle action 3
        })
     
        let cancelAction = UIAlertAction(title: "الغاء", style: .cancel, handler: {_ in
            

        })

        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        
        alertController.addAction(cancelAction)
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view // The view containing the anchor rectangle for the popover.
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // The rectangle in the specified view in which to anchor the popover.
            popoverController.permittedArrowDirections = [] // Optional: Arrow directions for the popover.
        }
        self.present(alertController, animated: true, completion: nil)
    }
    func removeItem(index: Int,realDele:Int =  0) {
        if index >= 0 && index < videoData.count {
            // Remove the item from the data source.
            
            
            if realDele == 1 {
                self.removeVideoForUser(videoId: self.videoData[index].nodeId)

            }
            videoData.remove(at: index)
            
            // Delete the corresponding row from the table view.
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            
            // Reload table view to update the tags of the remaining buttons.
            // Note: This may not be necessary if your cell configuration logic handles it correctly.
            tableView.reloadData()
        }
    }

    
    func getVideoDataItem(at index: Int) -> NewAppendItItems? {
        if index >= 0 && index < videoData.count {
            return videoData[index]
        } else {
            return nil
        }
    }
    
    func removeVideoForUser(videoId:String){
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        let link = URL(string: ServerConstants.BASE_URL  + "/user/deleteVideo")
        
        let param :[String:Any] = [
            
            "video_id": videoId,
          
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Helper.shared.getUserToken() ?? "")",
              
          ]
        AF.request(link!, method: .post, parameters: param,headers: headers).response { (response) in
            if response.error == nil {
                do {
                    
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    if jsonObj != nil {
                        
                        if let obj = jsonObj!["msg"] as? [String:Any] {
                            let  status = obj["status"] as? Int
                            let  message = obj["message"] as? String
                            
                            
                            
                            if status == 200 {
                                
//                                self.showSuccessHud(msg: "تم تسجيل الد خول بنجاح", hud: hud)

                                hud.dismiss()
                                    
                                self.navigationController?.popViewController(animated: true)
                                
                                
                                
                            } else {
//                                self.showWarningHud(msg: msg ?? "", hud: hud)
                                self.show(message: "يوجد خطاء", messageType: .failure)
                                hud.dismiss()
                                if let obj = jsonObj!["msg"] as? [String:Any] {
                                    
                                    //
                                    if let msg = obj["message"] as? String {
                                    
                                    //    self.showWarningHud(msg: msg ?? "", hud: hud)
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                }
            
                    
                 catch let err as NSError {
                    print("Error: \(err)")
                     hud.dismiss()
//                    self.serverError(hud: hud)
                }
            } else {
                print("Error")
                hud.dismiss()

//                self.serverError(hud: hud)
                
                
            }
        }
        
    }

}
//extension VidViewController: PresenterProtocol {
//    func refresh() {
//    }

