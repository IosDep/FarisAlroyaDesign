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
    
    
    let mainViewModel = MainViewModel()
    var userID = ""
    var userNameTxt = ""
    var userImageTxt = ""
    var fullNameTxt = ""
    var bandNames = ""
    var anim: LottieAnimationView!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
   
 
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        self.username.text = self.userNameTxt
//        self.fullname.text = self.fullNameTxt ?? self.bandNames
      
   
        if  self.userImageTxt == ""{
            self.userImage.image = UIImage(named: "navlogo")
        }else {
            self.userImage.sd_setImage(with:(URL(string: self.userImageTxt ?? "")), completed: { (image, error, cachType, url) in
                if error == nil {
                    self.userImage .image = image!
                    
                }
            })
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "VideoCell", bundle: nil), forCellWithReuseIdentifier: "VideoCell")
        
    getVideos()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
              layout.minimumInteritemSpacing = 0 // Adjust this value as needed
              layout.minimumLineSpacing = 0      // Adjust this value as needed
          }
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

//        DispatchQueue.main.async { [self] in
//            collectionView.reloadData()
//
//        }
       
        self.anim.loopMode = .loop
        
        // 3. Adjust animation speed
        self.anim.animationSpeed = 1
        anim.play()
        
        
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
    
    
    @IBAction func followersPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ContainerFollowListVC") as! ContainerFollowListVC
        
        vc.flag = 1
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    @IBAction func followingPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ContainerFollowListVC") as! ContainerFollowListVC
        
        vc.flag = 2
        self.navigationController?.pushViewController(vc, animated: false)

        
    }
    
    @IBAction func accountSettingPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        
        self.navigationController?.pushViewController(vc, animated: true)

//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
        
    }

    
    
    private func getVideos() {
        let uid = Helper.shared.getId() ?? ""
        mainViewModel.getMainVideos(uid: userID, state: "0", pageSize: 15,page: 1) { [weak self] hasMoreData, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Handle error
                    print("Error:", error.localizedDescription)
                    return
                }
                
                self?.collectionView?.reloadData()
            }
            if hasMoreData == true {
                self?.anim.isHidden = true

            }else {
                self?.anim.isHidden = false

            }
        }
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
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.mainViewModel.videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                    
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
            
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
        

        
        let h = 180.0
            let w = collectionView.bounds.width / 3

            return CGSize(width: w, height: h)
        
    }
    
}
