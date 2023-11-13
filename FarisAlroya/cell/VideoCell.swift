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
    var videoURL : String?
    var reels : [VideoReel] = []

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    

    
    

}
