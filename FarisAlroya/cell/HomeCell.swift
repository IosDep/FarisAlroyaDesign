//
//  HomeCell.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit
import AVFoundation

class HomeCell: UITableViewCell {
    
    
    
    @IBOutlet weak var videoPlayerView: UIView!
    
    
    var player: AVPlayer?
    var videoURL : String?
    var reels : [VideoReel] = []
    var index : Int?

    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layoutMargins = .zero
        self.preservesSuperviewLayoutMargins = false
                
        
        if let index = self.index {
            
            if let video = URL(string: reels[index].videoURL ?? "") {
                
//                self.playVideo(videoURL: video)
            }
            
        }
        
        
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func playVideo(videoURL: URL) {
        
        player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = videoPlayerView.bounds
        videoPlayerView.layer.addSublayer(playerLayer)
        player?.play()
        
    }

    
    
    
}
