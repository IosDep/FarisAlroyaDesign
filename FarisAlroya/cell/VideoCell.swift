//
//  VideoCell.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit
import AVKit

class VideoCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var videoPlayerView: UIView!
    
    var player: AVPlayer?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    func playVideo(with videoURL: URL) {
        
        player = AVPlayer(url: videoURL)
        
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = videoPlayerView.bounds
        
        videoPlayerView.layer.addSublayer(playerLayer)
        player?.play()
        
    }

    
    

}
