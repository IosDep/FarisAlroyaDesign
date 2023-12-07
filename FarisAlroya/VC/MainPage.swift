//
//  MainPage.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 24/11/2023.
//

import UIKit
import Lottie

class MainPage: UIViewController , MainVideoDelegate{
  
    @IBOutlet weak var watingsss: LottieAnimationView!
    var counts = 0
    var indx:Int = 0
    var stop_pagention = true
    var showItems = 0
    let mainViewModel = MainViewModel()
var autoScroll = 0
var videoData = [NewAppendItItems]()
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pauseAllVideos()
    }

    private func pauseAllVideos() {
        for cell in videoColletion.visibleCells as? [MainVideoCell] ?? [] {
            cell.player?.pause()
        }
    }
    
    
    @IBOutlet weak var menuItem: UIButton!
    @IBOutlet weak var loginItem: UIButton!
    
    @IBOutlet weak var profileBtn: UIButton!

    
    
    
    @IBOutlet weak var videoColletion: UICollectionView!
//    private var videoColletion:UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for _ in 0..<100{
//            let model = VideoModel(name: "Test 123 ", description: "Tewst ", imageThumb: "imgName", videoFileUrl: "https://assets.mixkit.co/videos/preview/mixkit-sun-over-hills-1183-large.mp4", userName: "jaebr", userId: "312", status: "jaber",profileImage: "https://cdn-icons-png.flaticon.com/512/3135/3135715.png")
//            videoData.append(model)
//        }
        self.watingsss.loopMode = .loop
        
        // 3. Adjust animation speed
        self.watingsss.animationSpeed = 1
        watingsss.play()
        if showItems == 0 {
            getVideos()

        }else {
            watingsss.isHidden = true
            self.videoColletion.reloadData()
            self.menuItem.setImage(UIImage(systemName: "xmark.seal.fill")?.withTintColor(.green), for: .normal)
//            self.videoColletion.scrollToItem(at:IndexPath(item: self.autoScroll, section: 0), at: .right, animated: true)
        }
//        self.menuItem.addTarget(self, action: #selector(back), for: .touchUpInside)
        
//        if ((Helper.shared.getId()?.isEmpty) != nil){
//
//
//            profileBtn.isHidden  =  false
//            menuItem.isHidden  =  false
//            loginItem.isHidden  = true
//
//        }else {
//            profileBtn.isHidden  =  true
//            menuItem.isHidden  =  true
//            loginItem.isHidden  = false
//
//        }
       
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        videoColletion?.collectionViewLayout = layout
//        videoColletion =  UICollectionView(frame: .zero,collectionViewLayout: layout)
        videoColletion?.dataSource = self
        videoColletion?.delegate = self
        videoColletion?.backgroundColor = .black
        getVideos()
        videoColletion?.isPagingEnabled = true

        videoColletion?.register(MainVideoCell.self, forCellWithReuseIdentifier: MainVideoCell.identfier)

        
//        self.view.addSubview(self.videoColletion!)
    }
    
    @objc func back(){
        self.dismiss(animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoColletion?.frame = view.bounds
    }
    @IBAction func loginItem(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
           appDelegate.notLogin()
    }
    
    @IBAction func menu(_ sender: Any) {
    }
    
    @IBAction func profileBtn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MianVC") as! MianVC
//        vc.videoModel = mainViewModel.videos
//        vc.modalPresentationStyle =  .fullScreen

        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    
    
    
}
extension MainPage :UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if showItems == 0{
            return mainViewModel.videos.count
        }else {
            return counts
        }
        

    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
          if let videoCell = cell as? MainVideoCell {
              videoCell.player?.play()
              videoCell.player?.isMuted = false
          }
//        if indexPath.item == mainViewModel.videos.count - 1 {
//            if mainViewModel.hasMoreData == true {
//                getVideos()
//            }else {
//
//            }
//
//              // pass currenPage number in API
//              // add data to array
//              // reload collectionview
//          }
      }

      func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
          if let videoCell = cell as? MainVideoCell {
              videoCell.player?.pause()
          }
  
      }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model  = mainViewModel.videos [indexPath.row]
        let cell  = videoColletion?.dequeueReusableCell(withReuseIdentifier: MainVideoCell.identfier, for: indexPath) as? MainVideoCell
        cell?.configModel(with: mainViewModel.videos[indexPath.row])
        
        
        cell?.delegate = self
        
        return cell!
    }
    
    private func getVideos() {
        mainViewModel.getMainVideos(uid: "65", state: "1", pageSize: 10,page: self.indx) { [weak self] hasMoreData, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Handle error
                    print("Error:", error.localizedDescription)
                    return
                }
                if hasMoreData == true {
                    self?.watingsss.isHidden = false

                }else {
                    self?.watingsss.isHidden = true
                }
                
                self?.videoColletion?.reloadData()
            }
        }
    }

    
    
    private func loadVideos() {
        let uid = Helper.shared.getId() ?? ""

        mainViewModel.getMainVideos(uid: "", state: "0", pageSize: 10,page: self.indx) { [weak self] hasMoreData, error in
            guard let strongSelf = self else { return }

            if let error = error {
                print("Error:", error.localizedDescription)
                self?.stop_pagention = true
                return
            }

            if hasMoreData == true {
                let currentCount = strongSelf.mainViewModel.videos.count
                let newCount = strongSelf.mainViewModel.videos.count + 3
                let indexPaths = (currentCount..<newCount).map { IndexPath(item: $0, section: 0) }

                DispatchQueue.main.async {
                    strongSelf.videoColletion?.insertItems(at: indexPaths)
                }
            }else {
                self?.stop_pagention = true
            }
        
        }
        
        
        
        
    }
    func didTapLikeBtn(with model: NewAppendItItems) {
   
    }
    
    func didProfileBtn(with model: NewAppendItItems) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileVC
//        vc.videoModel = mainViewModel.videos
        vc.userID =  model.userId
        vc.userNameTxt =  model.userName
        vc.fullNameTxt =  model.firstName  + model.lastName
        vc.userImageTxt =  model.userPic
//        vc.modalPresentationStyle =  .fullScreen
//        self.present(vc, animated: true)
        
        
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func didShareBtn(with model: NewAppendItItems) {
        
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = videoColletion.cellForItem(at: IndexPath(row: indexPath.row, section: 0)) as? MainVideoCell {
            
                cell.player?.play()
            
            cell.isSelected = true
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = videoColletion.cellForItem(at: IndexPath(row: indexPath.row, section: 0)) as? MainVideoCell {
            
                cell.player?.pause()
            
            cell.isSelected = false
            
        }
    }

  
    


//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        let height = scrollView.frame.size.height
//
//        if offsetY > contentHeight - height * 2 && !mainViewModel.isLoading && mainViewModel.hasMoreData {
//            loadMoreData()
//        }
//    }
//    extension MainPage: UIScrollViewDelegate {
//        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//            playVideoInVisibleCell()
//        }

       

//        private func stopAllVideoPlayback() {
//            for cell in videoColletion.visibleCells as? [MainVideoCell] ?? [] {
//                cell.player?.pause()
//            }
//        }
//


}
extension MainPage: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateVideoPlayback()
    }

    private func updateVideoPlayback() {
        // Assuming a vertical scroll direction
        let centralIndex = Int(round(videoColletion.contentOffset.y / videoColletion.frame.size.height))
        
        for i in 0..<mainViewModel.videos.count {
            if let cell = videoColletion.cellForItem(at: IndexPath(row: i, section: 0)) as? MainVideoCell {
                if i == centralIndex {
                    cell.player?.play()
                } else {
                    cell.player?.pause()
                }
            }
        }
    }
}

