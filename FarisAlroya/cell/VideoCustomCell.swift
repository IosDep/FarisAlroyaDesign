//
//  VideoCustomCell.swift
//  TikTok Video Feed Swift
//
//  Created by Cedan Misquith on 19/10/22.
//

import UIKit
import AVFoundation

class VideoCustomCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var bottomGradientImageView: UIImageView!
    @IBOutlet weak var playpause: UIButton!
    
    @IBOutlet weak var profileBtn: UIButton!

    @IBOutlet weak var more: UIButton!
    @IBOutlet weak var like_counts: UILabel!
    
    @IBOutlet weak var btnP: UIButton!
    @IBOutlet weak var playpayseImage: UIImageView!
    var playerController: VideoPlayerController?
    var videoLayer: AVPlayerLayer = AVPlayerLayer()
    @IBOutlet weak var userImages: UIImageView!
    var videoURL: String? {
//        didSet {
//            if let videoURL = videoURL {
//                VideoPlayerController.sharedVideoPlayer.setupVideoFor(url: videoURL)
//            }
//            videoLayer.isHidden = videoURL == nil
//        }
        didSet {
              if let videoURL = videoURL {
                  // Setup the player for the new videoURL
                  VideoPlayerController.sharedVideoPlayer.setupVideoFor(url: videoURL)
                  // Consider auto-playing here if that's the desired behavior
              }
              videoLayer.isHidden = videoURL == nil
          }
    }
    override func awakeFromNib() {
        let bottomGradient = Utilities.shared.createGradient(color1: UIColor.black.withAlphaComponent(0.0),
                                                             color2: UIColor.black.withAlphaComponent(0.7),
                                                             frame: bottomGradientImageView.bounds)
        bottomGradientImageView.contentMode = .scaleAspectFill
        bottomGradientImageView.image = bottomGradient
        self.contentView.backgroundColor = .black
        videoLayer.backgroundColor = UIColor.clear.cgColor
//        videoLayer.videoGravity = AVLayerVideoGravity.resize
        thumbnailImageView.layer.addSublayer(videoLayer)
        selectionStyle = .none
        playpayseImage.isHidden = true
        
        
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
//        self.addGestureRecognizer(tapGestureRecognizer)
        playpause.addTarget(self, action: #selector(cellTapped), for: .touchUpInside)
        
        
        
    }
    override func prepareForReuse() {
        thumbnailImageView.imageURL = nil
        

        super.prepareForReuse()
        

    }
    @objc func cellTapped() {
        togglePlayPause()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        videoLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    func configureCell(data: NewAppendItItems) {
//        self.thumbnailImageView.imageURL = data.thumbnailURL
        self.videoURL = data.videoUrl
        self.titleLabel.text = data.userName
        self.descriptionLabel.text = data.videoTitle
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspect // or resizeAspectFill
        self.like_counts.text = data.numofVideoLike
        
        if  data.userPic.isEmpty{
            self.userImages.image = UIImage(named: "navlogo")
        }else {
            self.userImages.sd_setImage(with:(URL(string: data.userPic)), completed: { (image, error, cachType, url) in
                if error == nil {
                    self.userImages.image = image!

                }
            })
        }
        
        
//      "1" ==>  user Have save or like before
        
        print("EWRTY",data.userFav)
        if data.userFav == true{
            self.likeBtn.setImage(UIImage(named:  "star_fill"), for: .normal)

        }else {
            self.likeBtn.setImage(UIImage(named:  "star"), for: .normal)
        }
        
        
        if data.userSave == true{
            self.saveBtn.setImage(UIImage(named:  "savefill"), for: .normal)

        }else {
            self.saveBtn.setImage(UIImage(named:  "save"), for: .normal)
        }
        
    }
    
    func togglePlayPause() {
        guard let videoURL = self.videoURL else { return }

        // Check if the video is currently playing
        if VideoPlayerController.sharedVideoPlayer.isCurrentlyPlaying(url: videoURL) {
            // If the video container for the current URL is playing, pause it
            if VideoPlayerController.sharedVideoPlayer.isVideoContainerPlaying(url: videoURL) {
                VideoPlayerController.sharedVideoPlayer.pauseCurrentVideo()
          
            } else {
                // Video is not playing, play it
                VideoPlayerController.sharedVideoPlayer.playVideo(withLayer: self.videoLayer, url: videoURL)
                playpayseImage.isHidden = true
            }
        } else {
            // This cell's video is not currently playing, so start it
            VideoPlayerController.sharedVideoPlayer.playVideo(withLayer: self.videoLayer, url: videoURL)
            playpayseImage.isHidden = true
        }
    }



    
}
extension VideoCustomCell: PlayVideoLayerContainer {
    func visibleVideoHeight() -> CGFloat {
        let videoFrameInParentSuperView: CGRect? = self.superview?.superview?.convert(
            thumbnailImageView.frame,
            from: thumbnailImageView)
        guard let videoFrame = videoFrameInParentSuperView,
              let superViewFrame = superview?.frame else {
                  return 0
              }
        let visibleVideoFrame = videoFrame.intersection(superViewFrame)
        return visibleVideoFrame.size.height
    }
}
