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
    
    var anim: LottieAnimationView!
    let mainViewModel = MainViewModel()

   
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    var videoModel = [NewAppendItItems]()
    
    @IBOutlet weak var analyticsBtn: UIButton!
    @IBOutlet weak var anlyticsView: UIView!
    @IBOutlet weak var dataPannelView: UIView!
    @IBOutlet weak var contentsView: UIView!
    
   
    
    
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
        
        getVideos()
        collectionView.register(UINib(nibName: "VideoCell", bundle: nil), forCellWithReuseIdentifier: "VideoCell")
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        anim = LottieAnimationView(name: "watings") // Replace "animationName" with your animation file's name

           // Set the frame or use Auto Layout constraints
           anim.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
           anim.center = self.view.center

           // Configure animation properties
           anim.contentMode = .scaleAspectFill
           anim.loopMode = .loop

           // Add it to your view
           self.view.addSubview(anim)

           // Start playing the animation
           anim.play()
        
    }
    
    
    @IBAction func accountSettingsPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AccountSettingsVC") as! AccountSettingsVC
        self.navigationController?.pushViewController(vc, animated: false)
        
        
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
    

    
    
    private func getVideos() {
        let uid = Helper.shared.getId() ?? ""
        mainViewModel.getMainVideos(uid: uid, state: "1", pageSize: 12,page: 1) { [weak self] hasMoreData, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Handle error
                    print("Error:", error.localizedDescription)
                    return
                }
                
                self?.collectionView?.reloadData()
            }
            if ((self?.mainViewModel.videos.isEmpty) != nil) {
                self?.anim.isHidden = true

            }else {
                self?.anim.isHidden = false

            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.mainViewModel.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        
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
            cell.images.image = UIImage(named: "navlogo")
        }else {
            cell.images.sd_setImage(with:(URL(string: model.imageThum)), completed: { (image, error, cachType, url) in
                if error == nil {
                    cell.images .image = image!
                    
                }
            })
        }
        cell.numb.isHidden = false
        cell.status.isHidden = false

        cell.numb.text  = "\(model.duration)"
        if model.type == "published"{
            contentsView.backgroundColor = .green
        }else {
            contentsView.backgroundColor = .red

        }
        cell.status.text = model.type
        
        
        
        return cell
}
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 3
        let spacingBetweenCells: CGFloat = 0 // No spacing between cells

        // Calculate the total horizontal padding
        let totalPadding: CGFloat = collectionView.contentInset.left + collectionView.contentInset.right

        // Calculate the width for each item
        let availableWidth = collectionView.bounds.width - totalPadding - (spacingBetweenCells * (numberOfItemsPerRow - 1))
        let widthPerItem = availableWidth / numberOfItemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem) // Adjust height as necessary
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
        let vc = storyBoard.instantiateViewController(withIdentifier: "MainPage") as! MainPage
        
//        vc.reels = self.reels
//        vc.index = indexPath.row
        vc.showItems = 1
        vc.mainViewModel.videos =  mainViewModel.videos
        vc.autoScroll = indexPath.row
        vc.counts = mainViewModel.videos.count
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
  
    @IBAction func dimisss(_ sender: Any) {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
}





struct VideoReel {
    var videoURL : String
}
