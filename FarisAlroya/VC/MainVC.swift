//
//  ProfileVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit
import AVFoundation
import Lottie

class MianVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var no_data: UILabel!
    var currentPage  = 1
    var anim: LottieAnimationView!
    let mainViewModel = MainViewModel()

    var userId = ""
    var userName = ""
    var numOfFollow = ""
    var numOfFollowing = ""
    var numOfLike = ""

    var userImageLink = ""
    var isFollowign = ""

    @IBOutlet weak var collectionView: UICollectionView!
    var videoModel = [NewAppendItItems]()
    
    @IBOutlet weak var analyticsBtn: UIButton!
    @IBOutlet weak var anlyticsView: UIView!
    @IBOutlet weak var dataPannelView: UIView!
    @IBOutlet weak var contentsView: UIView!
    
   
    
    
    @IBOutlet weak var userImage: UIImageView!

    @IBOutlet weak var userFollowerCount: UILabel!
    @IBOutlet weak var userFollowingCount: UILabel!
    @IBOutlet weak var userLikeCount: UILabel!

    @IBOutlet weak var userNameTxt: UILabel!
    
    
    @IBOutlet weak var followBtn: DesignableButton!
    @IBOutlet weak var unFollowBtn: DesignableButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.reels = [VideoReel(videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") , VideoReel(videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") ,   VideoReel(videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")]
        collectionView.isPagingEnabled = false
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getVideos(page:currentPage)
        collectionView.register(CustomVideoCell.self, forCellWithReuseIdentifier: "CustomVideoCell")
        
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

        
        self.userNameTxt.text = userName
        self.userFollowingCount.text = numOfFollowing
        self.userFollowerCount.text = numOfFollow
        self.userLikeCount.text = numOfLike
        
        
        if  userImageLink.isEmpty{
            userImage.image = UIImage(named: "navlogo")
        }else {
            userImage.sd_setImage(with:(URL(string: userImageLink)), completed: { (image, error, cachType, url) in
                if error == nil {
                    self.userImage.image = image!

                }
            })
        }
        let layout = UICollectionViewFlowLayout()
          layout.minimumInteritemSpacing = 0
          layout.minimumLineSpacing = 0
          collectionView.collectionViewLayout = layout


        collectionView.collectionViewLayout.invalidateLayout()


        
    }
    
    
    
    @IBAction func followersPressed(_ sender: Any) {
        
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ContainerFollowListVC") as! ContainerFollowListVC
        
            vc.flag = 1
        vc.commingFromUserOrProfile = 1

        vc.target_uid = userId

//            self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true)
        
    }
    
    @IBAction func followingPressed(_ sender: Any) {
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "ContainerFollowListVC") as! ContainerFollowListVC
        vc.commingFromUserOrProfile = 1

        vc.flag = 2
        vc.target_uid = userId
        self.present(vc, animated: true)

        
    }
    

    
    
    @IBAction func accountSettingsPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AccountSettingsVC") as! AccountSettingsVC
        self.navigationController?.pushViewController(vc, animated: false)
        
        
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doAction(_ sender: UIButton) {
      
        
        switch sender.tag {
            
        case 0:
            analyticsBtn.backgroundColor = .systemGray4
            contentsView.backgroundColor = .clear
            dataPannelView.backgroundColor = .clear

        case 1:
            anlyticsView.backgroundColor = .clear
            contentsView.backgroundColor = .systemGray4
            dataPannelView.backgroundColor = .clear
            
        case 2:
            anlyticsView.backgroundColor = .clear
            contentsView.backgroundColor = .clear
            dataPannelView.backgroundColor = .systemGray4
            
        default:
           print("defaultt")

        }
        
    }
    

    private func addFollwoUser(follower_id: String) {
        mainViewModel.followUnFollow(follower_id: follower_id) { [weak self] success, error in
            DispatchQueue.main.async {
                self?.anim.isHidden = true
                self?.anim.stop()
                

                if success {
                    self?.anim.isHidden = true
                    self?.anim.stop()
                    self?.showSuccessHud(msg: self?.mainViewModel.msgModel?.message ?? "")

                } else {
                    self?.showErrorHud(msg: "يرجى المحاولة مجددا")
                    self?.anim.isHidden = true
                    self?.anim.stop()
                    
                }
            }
        }
    }
    
    
    
    
    private func getVideos(page:Int) {
        
        mainViewModel.getMainVideos(uid: userId,isHome: "0", state: "1", pageSize: 10,page: self.currentPage) { [weak self] hasMoreData, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Handle error
                    print("Error:", error.localizedDescription)
                    
                    self?.no_data.isHidden =  false
//                    self?.collectionView.isHidden = true
                    if self?.isFollowign == "1"{
            //            i follow the user
                        
                        
                        self?.unFollowBtn.isHidden  = false
                        self?.followBtn.isHidden  = true

                    }else {
                        
                        self?.unFollowBtn.isHidden  = true
                        self?.followBtn.isHidden  = false

                        
                    }
                    return
                }
                self?.anim.stop()
                self?.collectionView?.reloadData()
                if self?.mainViewModel.videos.first?.target_user_follow_flag == 1{
        //            i follow the user
                    
                    
                    self?.unFollowBtn.isHidden  = false
                    self?.followBtn.isHidden  = true

                }else {
                    
                    self?.unFollowBtn.isHidden  = true
                    self?.followBtn.isHidden  = false

                    
                }
            }
            if ((self?.mainViewModel.videos.isEmpty) != nil) {
                self?.anim.isHidden = true
                self?.anim.stop()
                
                
                


            }else {
                self?.anim.isHidden = false

            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.mainViewModel.videos.count
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
        
        
        
        let model = self.mainViewModel.videos[indexPath.row]
        if  model.imageThum.isEmpty{
            cell.imageView.image = UIImage(named: "navlogo")
        }else {
            cell.imageView.sd_setImage(with:(URL(string: model.imageThum)), completed: { (image, error, cachType, url) in
                if error == nil {
                    cell.imageView .image = image!
                    
                }
            })
        }
//        cell.numb.isHidden = false
//        cell.status.isHidden = false
//
//        cell.numb.text  = "\(model.duration)"
//        cell.status.isHidden = true
//        print("ERTYUIO312",model.target_user_follow_flag)
//        if model.type == "published"{
//            cell.status.isHidden = true
//        }else {
//
//
//        }
//        cell.status.text = model.type
//
//
        
        return cell
}
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 3
        let spacingBetweenCells: CGFloat = 0
        let totalSpacing: CGFloat = (numberOfItemsPerRow - 1) * spacingBetweenCells

        let availableWidth = collectionView.bounds.width - totalSpacing
        let widthPerItem = availableWidth / numberOfItemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    
    @IBAction func profiles(_ sender: Any) {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "AccountSettingsVC") as! AccountSettingsVC
            
    //        vc.reels = self.reels
//    //        vc.index = indexPath.row
//            vc.showItems = 1
//            vc.mainViewModel.videos =  mainViewModel.videos
            self.navigationController?.pushViewController(vc, animated: false)
            
        
      
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "VidViewControllerForProfiel") as! VidViewControllerForProfiel
        
//        vc.reels = self.reels
//        vc.index = indexPath.row
//        vc.showItems = 1
        vc.state =  0
        vc.userId = self.userId
        vc.postion  = indexPath.row
        vc.currentPage =  self.currentPage
        vc.videoData  = self.mainViewModel.videos
        DispatchQueue.main.async {
            vc.tableView.reloadData()

        }
        
//        vc.autoScroll = indexPath.row
//        vc.counts = viewModel.videos.count
        self.navigationController?.pushViewController(vc, animated: false)
        
        
    }
  
    @IBAction func dimisss(_ sender: Any) {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func followAction(_ sender: Any) {
        
        
        self.unFollowBtn.isHidden  = false
        self.followBtn.isHidden  = true
        self.anim.isHidden =  false
        self.anim.play()
        
        self.addFollwoUser(follower_id: self.userId)
        
    }
    
    @IBAction func UnfollowAction(_ sender: Any) {
        
        self.unFollowBtn.isHidden  = true
        self.followBtn.isHidden  = false
        
        self.anim.isHidden =  false

        self.anim.play()
        
        self.addFollwoUser(follower_id: self.userId)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.size.height

            if offsetY > contentHeight - height {
                
                self.anim.isHidden  =  false
                self.anim.play()
                
                loadMoreVideos()
                print("TTTESTTT")
            }
        }

        private func loadMoreVideos() {
            if mainViewModel.hasMoreData && !mainViewModel.isLoading {
                currentPage += 1
                self.getVideos(page: currentPage)
            }
        }
    
}

struct VideoReel {
    var videoURL : String
}

class CustomVideoCell: UICollectionViewCell {
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
}
