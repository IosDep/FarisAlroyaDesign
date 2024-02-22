//
//  LiveStreamVideoSdk.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 16/01/2024.
//

import UIKit
import Lottie
class LiveStreamVideoSdk: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
 

    


    var anim: LottieAnimationView!
    let mainViewModel = MainViewModel()
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        


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


       
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView?.collectionViewLayout = layout

        collectionView?.dataSource = self
        collectionView?.delegate = self

        getVideos()
        collectionView?.isPagingEnabled = true
        collectionView?.register(LiveStreamCell.self, forCellWithReuseIdentifier: LiveStreamCell.identfier)

        
    
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "LiveStreamCell", for: indexPath) as! LiveStreamCell
        
        
        cell.configModel(with: mainViewModel.liveStramArray[indexPath.row])
        
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainViewModel.liveStramArray.count
    }
    
 
    
    private func getVideos() {
        
        mainViewModel.getLiveStreamData(){ [weak self] hasMoreData, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Handle error
                    print("Error:", error.localizedDescription)
                    return
                }
                self?.anim.stop()
                self?.collectionView?.reloadData()
            }
            if ((self?.mainViewModel.videos.isEmpty) != nil) {
                self?.anim.isHidden = true
                self?.anim.stop()


            }else {
                self?.anim.isHidden = false

            }
        }
    }
}
