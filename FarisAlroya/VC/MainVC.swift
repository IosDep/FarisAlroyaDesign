//
//  ProfileVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit

class MianVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource  , UICollectionViewDelegateFlowLayout {
    
    
   
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
   
    var reels : [VideoReel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reels = [VideoReel(videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") , VideoReel(videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") ,   VideoReel(videoURL: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        
        collectionView.register(UINib(nibName: "VideoCell", bundle: nil), forCellWithReuseIdentifier: "VideoCell")
        
    
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
        
       
    }
    
    
    @IBAction func accountSettingsPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AccountSettingsVC") as! AccountSettingsVC
        self.navigationController?.pushViewController(vc, animated: false)
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return reels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                    
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as? VideoCell
        
        
                
            return cell!
            
            
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // collectionView.bounds.height

        let h = 220.0
        let w = 130.0

        return CGSize(width: w, height: h)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        
        vc.reels = self.reels
        vc.index = indexPath.row
        
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    
    

}


struct VideoReel {
    var videoURL : String
}
