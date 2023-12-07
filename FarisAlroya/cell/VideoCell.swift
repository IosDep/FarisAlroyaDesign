//
//  VideoCell.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit
import AVKit

class VideoCell: UICollectionViewCell {
    
    
    @IBOutlet weak var numb: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var images: UIImageView!
    
    @IBOutlet weak var videoPlayerView: UIView!
    
    var player: AVPlayer?
    var videoURL : String?
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    

    
    

}
