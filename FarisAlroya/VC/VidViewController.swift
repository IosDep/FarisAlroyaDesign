//
//  ViewController.swift
//  TikTok Video Feed Swift
//
//  Created by Cedan Misquith on 19/10/22.
//

import UIKit
import Lottie
import Alamofire
class VidViewController: UIViewController {
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
    
    var star_lotte: LottieAnimationView!

    @IBOutlet weak var logins: UIButton!
    @IBOutlet weak var homeview: UIView!
    var isHome =  0
    var stop_pagention = true
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isHome == 1{
            self.homeview.isHidden  = true
        }else {
            self.homeview.isHidden  = false

        }
        
    }
    
    var lastPage = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradients()
        configureTableView()
        DispatchQueue.main.async {
            VideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: self.tableView)
            
        }
        
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
        getVideos(indx:indx,load:0)
        
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
        
        self.updateViewCont()

    }
    fileprivate func configureTableView() {
        tableView.isPagingEnabled = true
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(UINib(nibName: "VideoCustomCell", bundle: nil),
                           forCellReuseIdentifier: "VideoCustomCell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 130, right: 0)

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

    @objc func shareBtn(sender: UIButton) {
        let videoIndex = sender.tag // Assuming the button's tag is the video's index
        
        // Assuming getVideoDataItem(at:) returns an optional video object that includes a URL
        if let video = getVideoDataItem(at: videoIndex) {
            let videoURLString = video.videoTitle // The actual video URL to share
            let videoID = "123" // This should be dynamically determined based on your app's logic
            
            // Construct the deep link URL with your app's custom URL scheme
            let deepLinkURLString = "kanz://video?user/\(videoID)"
            
            // Create an activity view controller to share the video URL and deep link
            let activityViewController = UIActivityViewController(activityItems: [deepLinkURLString,videoURLString ], applicationActivities: nil)
            
            // iPad support: present the activity view controller as a popover
            if let popoverController = activityViewController.popoverPresentationController {
                popoverController.sourceView = sender // Use the sender button as the anchor
                popoverController.sourceRect = sender.bounds
                popoverController.permittedArrowDirections = .any
            }
            
            // Present the activity view controller
            present(activityViewController, animated: true, completion: nil)
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
 
    
    
    func updateViewCont(){
        
        
        let link = URL(string: ServerConstants.BASE_URL  + ServerConstants.getVersionCode)
        
        let param :[String:Any] = [
            
            "version_code": "3"
            
        ]
        
        
        AF.request(link!, method: .post, parameters: param).response { (response) in
            if response.error == nil {
                do {
                    
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    if jsonObj != nil {
                        
                        if let obj = jsonObj!["msg"] as? [String:Any] {
                            let  status = obj["status"] as? Int
                            let  message = obj["message"] as? String
                            
                            print("dbaksjld",jsonObj)

                            
                            if status == 200 {
                  
                            }else {
                                
                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                appDelegate.updateView()

                                
                                
                            }
                            
                            
                        }
                    }
                    
                }
                
                
                
                catch let err as NSError {
                    print("Error: \(err)")
                    
                    //                    self.serverError(hud: hud)
                }
            } else {
                print("Error")
                
                
                //                self.serverError(hud: hud)
                
                
            }
        }
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
    
    
    
     func favouriteActionDoubleClikc(sender: Int) {
      
         
        if self.videoData[sender].userFav == false {
            self.addRemoveFlagActionLike(entity_id: self.videoData[sender].nodeId ,entity_type: "node",flag_id : "favorites", completionHandler: { (result) in
                if result == true {
                    let indexPath = IndexPath(row:sender, section: 0)
                    let cell  = self.tableView.cellForRow(at: indexPath) as! VideoCustomCell
                    let color1 = UIColor(red: 24/255, green: 163/255, blue: 170/255, alpha: 1)
                    
                    cell.likeBtn.setImage(UIImage(named:  "star_fill")?.withTintColor(color1), for: .normal)
                    self.videoData[sender].userFav = true
                    let numLike = Int(self.videoData[sender].numofVideoLike ) ?? 0
                    
                    self.star_lotte.stop()
                    self.star_lotte.isHidden =  true

                        cell.like_counts.text = "\(numLike +  1)"
            

                 
                    //                    self.didPullToRefresh()
//                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                    
                    
                }
            })
            
        }else {
            self.addRemoveFlagActionLike(entity_id: self.videoData[sender].nodeId ,entity_type: "node",flag_id : "favorites", completionHandler: { (result) in
                if result == true {
                    let indexPath = IndexPath(row: sender, section: 0)
                    let cell  = self.tableView.cellForRow(at: indexPath) as! VideoCustomCell
                    cell.likeBtn.setImage(UIImage(named:  "star"), for: .normal)
                    let numLike = Int(self.videoData[sender].numofVideoLike ) ?? 0
                    self.star_lotte.stop()
                    self.star_lotte.isHidden =  true

//                    if numLike > 0{
//                        cell.like_counts.text = "\(numLike -  1)"
//
//                    }else {
//                        cell.like_counts.text = "\(numLike)"
//
//                    }
                    self.videoData[sender].userFav = false
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
        mainViewModel.getMainVideos(uid: "", isHome: "1", state: "2", pageSize: self.page , page: indx) { [weak self] (videos, error) in
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
extension VidViewController: UITableViewDelegate, UITableViewDataSource {
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
        
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        cell.addGestureRecognizer(doubleTapGesture)

          
        
        
        cell.saveBtn.tag =  indexPath.row
        cell.saveBtn.addTarget(self, action: #selector(self.savedAction(sender:)), for: .touchUpInside)
        
        
        
        
        cell.shareBtn.tag =  indexPath.row
        cell.shareBtn.addTarget(self, action: #selector(self.shareBtn(sender:)), for: .touchUpInside)
        cell.profileBtn.tag =  indexPath.row
        cell.profileBtn.addTarget(self, action: #selector(self.goToUserProfile(sender:)), for: .touchUpInside)
        
        
        
        
        cell.btnP.tag =  indexPath.row
        cell.btnP.addTarget(self, action: #selector(self.goToUserProfile(sender:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? PlayVideoLayerContainer {
            if videoCell.videoURL != nil {
                VideoPlayerController.sharedVideoPlayer.removeLayerFor(cell: videoCell)
            }
        }
        
    }
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: location) {
            // Now you have the index path of the tapped cell,
            // you can use it to get the video data and perform the favorite action
            
            // Assuming you have a method or logic to toggle the favorite state of a video
            self.star_lotte = LottieAnimationView(name: "star_lottie") // Replace "animationName" with your animation file's name
            
            // Set the frame or use Auto Layout constraints
            self.star_lotte.frame  = CGRect(x: 0, y: 0, width: 200, height: 200)
            self.star_lotte.center = self.view.center
            
            // Configure animation properties
            self.star_lotte.contentMode = .scaleAspectFill
   //         self.star_lotte.loopMode = .loop
            self.star_lotte.play()

            self.tableView.addSubview(self.star_lotte)
            
            self.favouriteActionDoubleClikc(sender: indexPath.row)
            
            
            
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
        
        

        let alertController = UIAlertController(title:"ساعدنا في ادارة المحتوى", message: nil, preferredStyle: .actionSheet)

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
        
        let alertController = UIAlertController(title:"حظر مستخدم", message: nil, preferredStyle: .actionSheet)

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
        

        let alertController = UIAlertController(title:"محتوى غير مرغوب فيه", message: nil, preferredStyle: .actionSheet)

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
    func removeItem(index: Int) {
        if index >= 0 && index < videoData.count {
            // Remove the item from the data source.
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
    
 
    

}
//extension VidViewController: PresenterProtocol {
//    func refresh() {
//    }

