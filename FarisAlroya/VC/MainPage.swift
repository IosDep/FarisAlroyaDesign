////
////  MainPage.swift
////  FarisAlroya
////
////  Created by MOHAMMED JABER on 24/11/2023.
////
//
//import UIKit
//import Lottie
//
//class MainPage: UIViewController , MainVideoDelegate{
//    var anim: LottieAnimationView!
//
//    
//    var counts = 0
//    var indx:Int = 0
//    var stop_pagention = true
//    var showItems = 0
//    private let threshold: CGFloat = 300 // Example value, adjust based on your cell's height or desired behavior
//
//    let mainViewModel = MainViewModel()
//var autoScroll = 0
//var videoData = [NewAppendItItems]()
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        pauseAllVideos()
//    }
//
//    private func pauseAllVideos() {
//        for cell in videoColletion.visibleCells as? [MainVideoCell] ?? [] {
//            cell.player?.pause()
//        }
//    }
//    
//    
//    @IBOutlet weak var menuItem: UIButton!
//    @IBOutlet weak var loginItem: UIButton!
//    @IBOutlet weak var profileBtn: UIButton!
//    @IBOutlet weak var videoColletion: UICollectionView!
////    private var videoColletion:UICollectionView?
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//        
//
//        
//
//
//        anim = LottieAnimationView(name: "watings") // Replace "animationName" with your animation file's name
//
//        
//       
//        // Set the frame or use Auto Layout constraints
//        anim.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        anim.center = self.view.center
//
//        // Configure animation properties
//        anim.contentMode = .scaleAspectFill
//        anim.loopMode = .loop
//
//        // Add it to your view
//        self.view.addSubview(anim)
//
//        // Start playing the animation
//        anim.play()
//
//
//       
//        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
//        videoColletion?.collectionViewLayout = layout
//
//        videoColletion?.dataSource = self
//        videoColletion?.delegate = self
//
//        getVideos()
//        videoColletion?.isPagingEnabled = true
//        videoColletion?.register(MainVideoCell.self, forCellWithReuseIdentifier: MainVideoCell.identfier)
//
//        
//
//    }
//    
//    
//    
//    @IBAction func livePressed(_ sender: Any) {
//        
//        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "ContainerPageVC") as! ContainerPageVC
//    
//        self.navigationController?.pushViewController(vc, animated: false)
//    
//    }
//    
//    
//    @objc func back(){
//        self.dismiss(animated: true)
//    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        if let flowLayout = videoColletion.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height)
//            flowLayout.minimumInteritemSpacing = 0
//            flowLayout.minimumLineSpacing = 0
//        }
//    }
//
//    @IBAction func loginItem(_ sender: Any) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//           appDelegate.notLogin()
//    }
//    
//    @IBAction func menu(_ sender: Any) {
//    }
//    
//    @IBAction func profileBtn(_ sender: Any) {
//        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "MianVC") as! MianVC
//
////        vc.modalPresentationStyle =  .fullScreen
//
//        self.navigationController?.pushViewController(vc, animated: false)
//    }
//    
//    func didTapVideoCell(_ cell: MainVideoCell) {
//           guard let indexPath = videoColletion.indexPath(for: cell) else { return }
//           let isPlaying = cell.player?.timeControlStatus == .playing
//
//           if isPlaying {
//               cell.player?.pause()
//           } else {
//               cell.player?.play()
//           }
//
//           cell.togglePlayPauseIcon(isPlaying: !isPlaying)
//        
//        print("TEEETTTS","123")
//       }
//    
//    
//}
//
//extension MainPage :UICollectionViewDataSource,UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return   videoData.count
//        
//
//    }
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//          if let videoCell = cell as? MainVideoCell {
//              videoCell.player?.play()
//              videoCell.player?.isMuted = false
//          }
//        
//    
//        
//        
//
//      }
//
//      func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//          if let videoCell = cell as? MainVideoCell {
//              videoCell.player?.pause()
//          }
//  
//      }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let model  = videoData [indexPath.row]
//        let cell  = videoColletion?.dequeueReusableCell(withReuseIdentifier: MainVideoCell.identfier, for: indexPath) as? MainVideoCell
//        cell?.configModel(with: videoData[indexPath.row])
//        cell?.delegate = self
//        
////        likeBtn
//        cell?.likeBtn.tag =  indexPath.row
//        cell?.likeBtn.addTarget(self, action: #selector(self.favouriteAction(sender:)), for: .touchUpInside)
//        
//        cell?.saveBtn.tag =  indexPath.row
//        cell?.saveBtn.addTarget(self, action: #selector(self.savedAction(sender:)), for: .touchUpInside)
//        
//        
//        cell?.profileBtn.tag =  indexPath.row
//        cell?.profileBtn.addTarget(self, action: #selector(self.goToUserProfile(sender:)), for: .touchUpInside)
//        
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(videoCellTapped(_:)))
//             cell?.addGestureRecognizer(tapGesture)
////        saveBtn
//        
//        return cell!
//    }
//    
//    @objc private func videoCellTapped(_ sender: UITapGestureRecognizer) {
//        if let cell = sender.view as? MainVideoCell {
//            cell.togglePlayback()
//        }
//    }
//    @objc func goToUserProfile(sender: UIButton) {
//        
//        let data = videoData[sender.tag]
//        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "MianVC") as! MianVC
//
////        vc.modalPresentationStyle =  .fullScreen
//
//        vc.userId = data.userId
//        vc.userName = data.userName
//        vc.userImageLink = data.userPic
//        vc.numOfLike = "\(data.numOfLikes)"
//        vc.numOfFollow = "\(data.numOfFollowers)"
//        vc.numOfFollowing = "\(data.numOfFollowing)"
//        vc.isFollowign =  "\(data.target_user_follow_flag)"
//        self.navigationController?.pushViewController(vc, animated: false)
//        
//        
//        
//        
//    }
//    
//    private func getVideos() {
//        let uid = Helper.shared.getId() ?? ""
//
//        mainViewModel.getMainVideos(uid: "", isHome: "1", state: "0", pageSize: 3, page: mainViewModel.currentPage) { [weak self] (videos, error) in
//            DispatchQueue.main.async {
//                if let error = error {
//                    print("Error:", error.localizedDescription)
//                    return
//                }
//
//                if !videos.isEmpty {
//                    let oldCount = self?.videoData.count ?? 0
//                    self?.videoData.append(contentsOf: videos)
//                    let newCount = self?.videoData.count ?? 0
//                    let indexPaths = (oldCount..<newCount).map { IndexPath(item: $0, section: 0) }
//                    self?.anim.stop()
//                    self?.anim.isHidden = true
//                    self?.videoColletion.reloadData()
////                    self?.videoColletion.performBatchUpdates({
////                        self?.videoColletion.insertItems(at: indexPaths)
////                    }, completion: { _ in
////                        if let newFirstItemIndex = indexPaths.first {
////                            // Optional: Scroll to the first item of the new data
////                            self?.videoColletion.scrollToItem(at: newFirstItemIndex, at: .top, animated: false)
////                        }
////                    })
//                } else {
//                    self?.mainViewModel.hasMoreData = false
//                    self?.anim.isHidden = true
//                }
//            }
//        }
//    }
//
//
//
//    
//    @objc func favouriteAction(sender: UIButton) {
//      
//        if self.videoData[sender.tag].userFav == "0" {
//            self.addRemoveFlagAction(entity_id: self.videoData[sender.tag].nodeId ,entity_type: "node",flag_id : "favorites", completionHandler: { (result) in
//                if result == true {
//                    let indexPath = IndexPath(row: sender.tag, section: 0)
//                    let cell = self.videoColletion!.cellForItem(at: indexPath) as! MainVideoCell
//                    let color1 = UIColor(red: 24/255, green: 163/255, blue: 170/255, alpha: 1)
//
//                    cell.likeBtn.setImage(UIImage(named:  "star_fill")?.withTintColor(color1), for: .normal)
//                    self.videoData[sender.tag].userFav = "1"
////                    self.didPullToRefresh()
//
//                    self.videoColletion.reloadItems(at: [indexPath])
//                }
//            })
//            
//        }else {
//            self.addRemoveFlagAction(entity_id: self.videoData[sender.tag].nodeId ,entity_type: "node",flag_id : "favorites", completionHandler: { (result) in
//                if result == true {
//                    let indexPath = IndexPath(row: sender.tag, section: 0)
//                    let cell = self.videoColletion!.cellForItem(at: indexPath) as! MainVideoCell
//                    cell.likeBtn.setImage(UIImage(named:  "star"), for: .normal)
//                    self.videoData[sender.tag].userFav = "0"
//                    self.videoColletion.reloadItems(at: [indexPath])
//                    
////                    self.didPullToRefresh()
//                    
//                }
//            })
//            
//        }
//        
//        
//    }
//    
//    @objc func savedAction(sender: UIButton) {
//      
//        if self.videoData[sender.tag].userSave == "0" {
//            self.addRemoveFlagAction(entity_id: videoData[sender.tag].nodeId ,entity_type: "node",flag_id : "save", completionHandler: { (result) in
//                if result == true {
//                    let indexPath = IndexPath(row: sender.tag, section: 0)
//                    let cell = self.videoColletion!.cellForItem(at: indexPath) as! MainVideoCell
//                    let color1 = UIColor(red: 24/255, green: 163/255, blue: 170/255, alpha: 1)
//
//                    cell.likeBtn.setImage(UIImage(named:  "savefill")?.withTintColor(color1), for: .normal)
//                    self.videoData[sender.tag].userSave = "1"
////                    self.didPullToRefresh()
//
//                    self.videoColletion.reloadItems(at: [indexPath])
//                }
//            })
//            
//        }else {
//            self.addRemoveFlagAction(entity_id: self.videoData[sender.tag].nodeId ,entity_type: "node",flag_id : "save", completionHandler: { (result) in
//                if result == true {
//                    let indexPath = IndexPath(row: sender.tag, section: 0)
//                    let cell = self.videoColletion!.cellForItem(at: indexPath) as! MainVideoCell
//                    cell.likeBtn.setImage(UIImage(named:  "save"), for: .normal)
//                    self.videoData[sender.tag].userSave = "0"
//                    self.videoColletion.reloadItems(at: [indexPath])
//                    
////                    self.didPullToRefresh()
//                    
//                }
//            })
//            
//        }
//        
//        
//    }
//    
//    
//
//    func didTapLikeBtn(with model: NewAppendItItems) {
//   
//    }
//    
//    
//    func didTapComment(with model: NewAppendItItems) {
//        
//    }
//    
//    func didTapSave(with model: NewAppendItItems) {
//        
//    }
//    
//    
//    func didProfileBtn(with model: NewAppendItItems) {
//        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "MianVC") as! MianVC
//
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    func didShareBtn(with model: NewAppendItItems) {
//        
//    }
//        
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = videoColletion.cellForItem(at: IndexPath(row: indexPath.row, section: 0)) as? MainVideoCell {
//            
//                cell.player?.play()
//            
//            cell.isSelected = true
//            
//            cell.playIconImageView.isHidden = false
//
//            
//        }
//        
//    }
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if let cell = videoColletion.cellForItem(at: IndexPath(row: indexPath.row, section: 0)) as? MainVideoCell {
//            
//            cell.player?.pause()
//            cell.isSelected = false
//            
//        }
//    }
//
//
//
//    
//
//        func loadVideos() {
//            let uid = Helper.shared.getId() ?? ""
//
//            mainViewModel.getMainVideos(uid: "", isHome: "1", state: "0", pageSize: 4, page: mainViewModel.currentPage) { [weak self] (videos, error) in
//                DispatchQueue.main.async {
//                    if let error = error {
//                        // Handle error scenario
//                        print("Error: \(error.localizedDescription)")
//                        return
//                    }
//
//                    if !videos.isEmpty {
//                        let oldCount = self?.videoData.count ?? 0
//                        self?.videoData.append(contentsOf: videos)
//                        let newCount = self?.videoData.count ?? 0
//                        let indexPaths = (oldCount..<newCount).map { IndexPath(item: $0, section: 0) }
//                        self?.anim.stop()
//                        self?.anim.isHidden = true
//
//                        self?.videoColletion.performBatchUpdates({
//                            self?.videoColletion.insertItems(at: indexPaths)
//                        }, completion: { _ in
//                            if let newFirstItemIndex = indexPaths.first {
//                                // Optional: Scroll to the first item of the new data
//                                self?.videoColletion.scrollToItem(at: newFirstItemIndex, at: .top, animated: false)
//                            }
//                        })
//                    } else {
//                        self?.mainViewModel.hasMoreData = false
//                        self?.anim.isHidden = true
//                    }
//                }
//            }
//        }
//
//
//}
//
//extension MainPage: UIScrollViewDelegate {
//
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        let height = scrollView.frame.size.height
//
//        // Check if near the bottom and if more data is available
//        if offsetY > contentHeight - height - threshold && !mainViewModel.isLoading && mainViewModel.hasMoreData {
//            self.anim.play()
//            loadVideos()
//        }
//    }
// 
//    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        updateVideoPlayback()
//    }
//
//    private func updateVideoPlayback() {
//        // Assuming a vertical scroll direction
//        let centralIndex = Int(round(videoColletion.contentOffset.y / videoColletion.frame.size.height))
//        
//        for i in 0..<videoData.count {
//            if let cell = videoColletion.cellForItem(at: IndexPath(row: i, section: 0)) as? MainVideoCell {
//                if i == centralIndex {
//                    cell.player?.play()
//                } else {
//                    cell.player?.pause()
//                }
//            }
//        }
//    }
//}
