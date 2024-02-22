//
//  UserProfileVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 05/12/2023.

import UIKit
import Lottie

class UserProfileVC: UIViewController  , UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var videoReelsBtn: UIButton!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    var flag : Int?
    var currentPage = 1
    var currentPage2 = 1
    var refreshControl: UIRefreshControl!
    
    
    let viewModel = MainViewModel()
    var userID = ""
    var userNameTxt = ""
    var userImageTxt = ""
    var fullNameTxt = ""
    var bandNames = ""
//    var anim: LottieAnimationView!
    
    @IBOutlet weak var anim: UIActivityIndicatorView!
    @IBOutlet weak var username: UILabel!
    
    
    @IBOutlet weak var numOfFollower: UILabel!
    
    @IBOutlet weak var numOFFollowing: UILabel!
    
    @IBOutlet weak var numOfLike: UILabel!
    
    @IBOutlet weak var noData: UILabel!
    
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        anim.startAnimating()

        getUserProfile()
        
        if flag == 1 {
            getVideos(page: currentPage)
            
        }else {
            anim.startAnimating()

            getSaveVideos(page: currentPage2)
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
        backButton.title = "رجوع" // Set your custom title
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        // Set the frame or use Auto Layout constraints
        
//
//        anim = LottieAnimationView(name: "watings") // Replace "animationName" with your animation file's name
//
//        anim.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        anim.center = self.view.center
//
//        // Configure animation properties
//        //           anim.contentMode = .scaleAspectFill
//        anim.loopMode = .loop
//
//        // Add it to your view
//        self.view.addSubview(anim)
//
//        // Start playing the animation
        anim.startAnimating()
//
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CustomVideoCell.self, forCellWithReuseIdentifier: "CustomVideoCell")
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        
        
        collectionView.collectionViewLayout.invalidateLayout()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.collectionView.addSubview(refreshControl)
        
 
        
        
        
        if self.viewModel.videos.isEmpty || self.viewModel.videos.count == 0 {
//            self.collectionView.isHidden = true
            self.noData.isHidden  = false
        }else {
//            self.collectionView.isHidden = false
            self.noData.isHidden  = true
        }
//        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height)
//            flowLayout.minimumInteritemSpacing = 0
//            flowLayout.minimumLineSpacing = 0
//        }
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//

//        DispatchQueue.main.async { [self] in
//            collectionView.reloadData()
//
//        }
       
//        self.anim.loopMode = .loop
//
//        // 3. Adjust animation speed
//        self.anim.animationSpeed = 1
        
        
        // save selected
        
        if flag == 1 {
            videoReelsBtn.setImage(UIImage(named: "videofill"), for: .normal)
            saveBtn.setImage(UIImage(named: "save 1"), for: .normal)

        }
        
        
        else {
            videoReelsBtn.setImage(UIImage(named: "video 1"), for: .normal)
            saveBtn.setImage(UIImage(named: "savefill"), for: .normal)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @IBAction func doAction(_ sender: UIButton) {
        
        if sender.tag == 1 {
            
            videoReelsBtn.setImage(UIImage(named: "videofill"), for: .normal)
            saveBtn.setImage(UIImage(named: "save 1"), for: .normal)

            
        }
        
        else {
            
            videoReelsBtn.setImage(UIImage(named: "video 1"), for: .normal)
            saveBtn.setImage(UIImage(named: "savefill"), for: .normal)
        }
        
    }
    
    
    
    @IBAction func followersPressed(_ sender: Any) {
        
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ContainerFollowListVC") as! ContainerFollowListVC
        
            vc.flag = 1
        vc.commingFromUserOrProfile = 0

        vc.target_uid = "nil"

            self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func followingPressed(_ sender: Any) {
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "ContainerFollowListVC") as! ContainerFollowListVC
    
        vc.flag = 2
        vc.commingFromUserOrProfile = 0
        vc.target_uid = "nil"

        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    

   
    
    @IBAction func accountSettingPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        
        self.navigationController?.pushViewController(vc, animated: true)

//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
        
    }

    
    
    private func getVideos(page: Int) {
          let uid = Helper.shared.getNewId() ?? 0
        self.refreshControl.endRefreshing()

        print("UUID",uid)
          viewModel.getMainVideos(uid: "",isHome: "0", state: "0", pageSize: 7, page: page) { [weak self] videos, error in
              DispatchQueue.main.async {
                  if let error = error {
                      // Handle error
                      print("Error:", error.localizedDescription)
                      self?.anim.stopAnimating()
                      self?.anim.isHidden = true
                      
                      
                      self?.noData.isHidden =  false
                      self?.collectionView.isHidden = true
                      
                      
                      
                      return
                  }
                  self?.noData.isHidden = true

                  
                  if page > 1 {
                      self?.viewModel.videos.append(contentsOf: videos)
                  } else {
                      self?.viewModel.videos = videos
                  }
             
                  
//                  if page == 1{
//                      self?.anim.startAnimating()
//                      self?.anim.isHidden = false
//
//                      self?.getVideos(page: (self?.currentPage ?? 0) + 1 ?? 2)
//                  }
//                  if page == 2{
//                      self?.anim.play()
//                      self?.anim.isHidden = false
//
//                      self?.getVideos(page: (self?.currentPage ?? 0) + 1 ?? 2)
//                  }
//                  if page == 3{
//                      self?.anim.play()
//                      self?.anim.isHidden = false
//
//                      self?.getVideos(page: (self?.currentPage ?? 0) + 1 ?? 2)
//                  }
//                  if page == 4{
//                      self?.anim.play()
//                      self?.anim.isHidden = false
//
//                      self?.getVideos(page: (self?.currentPage ?? 0) + 1 ?? 2)
//                  }
//                  if page == 5{
//                      self?.anim.play()
//                      self?.anim.isHidden = false
//
//                      self?.getVideos(page: (self?.currentPage ?? 0) + 1 ?? 2)
//                  }
                  self?.anim.stopAnimating()
                  self?.refreshControl.endRefreshing()

                  self?.anim.isHidden = true
                  self?.collectionView?.reloadData()
              }
          }
      }
    
    
    @objc func didPullToRefresh() {
        self.viewModel.videos.removeAll()
        self.collectionView.reloadData()
        self.getVideos(page: 1)
    }
    
    private func getSaveVideos(page: Int) {

        self.anim.startAnimating()
        self.anim.isHidden =  false
        let uid = Helper.shared.getNewId() ?? 0
      self.refreshControl.endRefreshing()

      print("UUID",uid)
        viewModel.getSavedVideos(uid: "",isHome: "0", state: "2", pageSize: 12, page: page) { [weak self] videos, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Handle error
                    print("Error:", error.localizedDescription)
                    self?.anim.stopAnimating()
                    self?.anim.isHidden = true
                    
                    
                    self?.noData.isHidden =  false
                    self?.collectionView.isHidden = true
                    
                    
                    
                    return
                }
                self?.noData.isHidden = true

//
//                if page > 1 {
//                    self?.viewModel.videos.append(contentsOf: videos)
//                } else {
                    self?.viewModel.videos = videos
//                }
           
                
//                  if page == 1{
//                      self?.anim.startAnimating()
//                      self?.anim.isHidden = false
//
//                      self?.getVideos(page: (self?.currentPage ?? 0) + 1 ?? 2)
//                  }
//                  if page == 2{
//                      self?.anim.play()
//                      self?.anim.isHidden = false
//
//                      self?.getVideos(page: (self?.currentPage ?? 0) + 1 ?? 2)
//                  }
//                  if page == 3{
//                      self?.anim.play()
//                      self?.anim.isHidden = false
//
//                      self?.getVideos(page: (self?.currentPage ?? 0) + 1 ?? 2)
//                  }
//                  if page == 4{
//                      self?.anim.play()
//                      self?.anim.isHidden = false
//
//                      self?.getVideos(page: (self?.currentPage ?? 0) + 1 ?? 2)
//                  }
//                  if page == 5{
//                      self?.anim.play()
//                      self?.anim.isHidden = false
//
//                      self?.getVideos(page: (self?.currentPage ?? 0) + 1 ?? 2)
//                  }
                self?.anim.stopAnimating()
                self?.refreshControl.endRefreshing()

                self?.anim.isHidden = true
                self?.collectionView?.reloadData()
            }
        }
      }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "VidViewControllerForProfiel") as! VidViewControllerForProfiel
        
//        vc.reels = self.reels
//        vc.index = indexPath.row
//        vc.showItems = 1
        vc.state =  1
        vc.userId = "nil"
        vc.postion  = indexPath.row
        vc.currentPage =  self.currentPage
        vc.videoData  = self.viewModel.videos
//        DispatchQueue.main.async {
//            vc.tableView.reloadData()
//
//        }
        
//        vc.autoScroll = indexPath.row
//        vc.counts = viewModel.videos.count
        self.navigationController?.pushViewController(vc, animated: false)

//        self.present(vc, animated: <#T##Bool#>)
        
    }
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.viewModel.videos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "CustomVideoCell", for: indexPath) as! CustomVideoCell
        
        //        let str = reels[indexPath.row].videoURL
        //        if let url = URL(string: str) {
        //            let playerItem = AVPlayerItem(url: url)
        //
        //            // Create an AVPlayer with the player item
        //            cell.player = AVPlayer(playerItem: playerItem)
        //
        //            // Create an AVPlayerLayer to display the video
        //            let playerLayer = AVPlayerLayer(player: cell.player)
        //            playerLayer.frame = cell.contentView.bounds
        //            playerLayer.videoGravity = .resizeAspectFill
        //
        //            // Add the player layer to the cell's content view layer
        //            cell.contentView.layer.addSublayer(playerLayer)
        //
        //            // Play the video
        //            cell.player?.play()
        //
        //        }
        
        
        
        let model = self.viewModel.videos[indexPath.row]
        if  model.imageThum.isEmpty{
            cell.imageView.image = UIImage(named: "navlogo")
        }else {
            cell.imageView.sd_setImage(with:(URL(string: model.imageThum)), completed: { (image, error, cachType, url) in
                if error == nil {
                    cell.imageView .image = image!
                    
                }
            })
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
//        // collectionView.bounds.height
//
//        let h = 220.0
//        let w = 130.0
//
//        return CGSize(width: w, height: h)
//
//
//    }
    


    @IBAction func bacss(_ sender: Any) {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 3
        let spacingBetweenCells: CGFloat = 0
        let totalSpacing: CGFloat = (numberOfItemsPerRow - 1) * spacingBetweenCells

        let availableWidth = collectionView.bounds.width - totalSpacing
        let widthPerItem = availableWidth / numberOfItemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    private func getUserProfile() {

    
        viewModel.getUserProfileData() { [weak self] success, error in
                if success {
                    // Update your UI with the results
                    // For example, reload a table view or collection view
                   let data  = self?.viewModel.profileList?.results
                    self?.userImageTxt = data?.profile_image ?? ""
                        
                    if  self?.userImageTxt == ""{
                        self?.userImage.image = UIImage(named: "navlogo")
                    }else {
                        self?.userImage.sd_setImage(with:(URL(string: self?.userImageTxt ?? "")), completed: { (image, error, cachType, url) in
                            if error == nil {
                                self?.userImage .image = image!
                                
                            }
                        })
                    }
                    
                    self?.username.text =  data?.user_name ?? ""
                    self?.numOfLike.text = "\(data?.likes_count ?? "")"
                    self?.numOfFollower.text = "\(data?.followers_count ?? "")"
                    self?.numOFFollowing.text = "\(data?.following_count ?? "")"

           


                } else if let error = error {
                    // Handle the error, maybe show an alert to the user
                    print("Error occurred during search: \(error.localizedDescription)")
                    self?.showErrorHud(msg:"Error occurred during search:" )
                    
                }
            }
        }
       
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.size.height

            if offsetY > contentHeight - height {
                
                self.anim.isHidden  =  false
                self.anim.startAnimating()
                
                loadMoreVideos()
                print("TTTESTTT")
            }
        }

        private func loadMoreVideos() {
            if viewModel.hasMoreData && !viewModel.isLoading {
                currentPage += 1
                getVideos(page: currentPage)
            }
        }
    
}
