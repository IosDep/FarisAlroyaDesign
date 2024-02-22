//
//  MainVideoCell.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 24/11/2023.
//

import UIKit
import AVFoundation
import SDWebImage



protocol MainVideoDelegate : AnyObject{
    func didTapLikeBtn(with model:NewAppendItItems)
    func didProfileBtn(with model:NewAppendItItems)
    func didShareBtn(with model:NewAppendItItems)
    func didTapComment(with model:NewAppendItItems)
    func didTapSave(with model:NewAppendItItems)
    func didTapVideoCell(_ cell: MainVideoCell)


}


class MainVideoCell: UICollectionViewCell {
    var player: AVPlayer?
     var playerLayer: AVPlayerLayer?
    
     let videoContainer = UIView()
    var model:NewAppendItItems?
    static let identfier = "MainVideoCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupVideoContainer()
        
        setupPlayIconImageView()

    }
    
    
     func setupVideoContainer() {
        videoContainer.layer.masksToBounds = true
        contentView.addSubview(videoContainer)
        contentView.sendSubviewToBack(videoContainer)
    }

    
    let playIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "save")) // Replace "playIcon" with your play icon image name
        imageView.contentMode = .center
        imageView.isHidden = true // Initially hidden
        return imageView
    }()


    
     let profileImageView: UIImageView = {
            let imageView = UIImageView()
        
        imageView.image = UIImage(named: "profile")
        
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
            return imageView
        }()
    
    
     let profileBtn: UIButton = {
            let btn = UIButton()
        btn.setImage(UIImage(named: "profile"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.imageView?.layer.cornerRadius = 20
        btn.imageView?.clipsToBounds = true
            return btn
        }()
    

    
     let buttonStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .equalSpacing
            stackView.spacing = 7
            return stackView
        }()
   
    
     let likeStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
       stackView.alignment = .center
       stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
        }()
    
     let likeLabel:UILabel = {
         let lbl = UILabel()
        
         lbl.textAlignment = .left
         lbl.textColor = .white
 return lbl
    }()
    
     let commentStack: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
            stackView.spacing = 0
            return stackView
        }()
    
     let commentLabel:UILabel = {
         let lbl = UILabel()
        lbl.text = "5"
         lbl.textAlignment = .center
         lbl.textColor = .white
        lbl.font.withSize(8.0)
 return lbl
    }()
    
    
     
    
    
    let userName:UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = .white
return lbl
   }()
    
    let profileBtnClicked: UIButton = {
           let btn = UIButton()
       btn.setImage(UIImage(named: ""), for: .normal)
       btn.imageView?.contentMode = .scaleAspectFill
       btn.imageView?.layer.cornerRadius = 20
       btn.imageView?.clipsToBounds = true
           return btn
       }()
   
    
    
     let descriptions:UILabel = {
         let lbl = UILabel()
         lbl.textAlignment = .left
         lbl.textColor = .white
        
 return lbl
    }()
    
    
     let profileButton:UIButton = {
         let button = UIButton()
        button.setBackgroundImage (UIImage (systemName: "person.circle"), for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        return button
 
    }()
    
     let imageBtn:UIImageView = {
         let button = UIImageView()
        return button
 
    }()
    
    
     let likeBtn:UIButton = {
         let button = UIButton()
//        button.setBackgroundImage (UIImage (systemName: "heart.fill"), for: .normal)
        button.setImage(UIImage(named: "fav"), for: .normal)

        return button
 
    }()
    
     let commentBtn:UIButton = {
         let button = UIButton()
        button.setImage(UIImage(named: "comment"), for: .normal)

        return button
 
    }()
    
     let saveBtn:UIButton = {
         let button = UIButton()
//        button.setBackgroundImage (UIImage (systemName: "heart.fill"), for: .normal)
        button.setImage(UIImage(named: "save" ), for: .normal)

        return button
 
    }()
    
     let shareBtn:UIButton = {
        
        let button = UIButton()
//        button.setBackgroundImage (UIImage (systemName: "heart.fill"), for: .normal)
       button.setImage(UIImage(named: "share 3" ), for: .normal)

       return button
 
    }()
    
    weak var delegate:MainVideoDelegate?
    
    func config(with model:VideoModel){
      
        
     
    }
    
    func configModel ( with model:NewAppendItItems){

        
     
        self.model  = model
//
        self.userName.text = model.userName
        self.descriptions.text = model.videoTitle
        print("ERTYUIO", model.videoDesc)
//
        if  model.userPic.isEmpty{
            imageBtn.image = UIImage(named: "navlogo")
        }else {
            imageBtn.sd_setImage(with:(URL(string: model.userPic)), completed: { (image, error, cachType, url) in
                if error == nil {
                    self.imageBtn.image = image!

                }
            })
        }

    
        
        
//        appned data
        if (model.userFav != true){
            likeBtn.setImage(UIImage(named: "star"), for: .normal)

        }else {
            likeBtn.setImage(UIImage(named: "star_fill"), for: .normal)

        }
        
        
        
        
            if (model.userSave != true){
                saveBtn.setImage(UIImage(named: "save"), for: .normal)

            }else {
                saveBtn.setImage(UIImage(named: "savefill"), for: .normal)

            }
        
        
        userName.text = model.userName
        descriptions.text = model.videoTitle
        likeLabel.text = model.numOfLikes ?? "0"
      
        prepareVideo(urlString: model.videoUrl ?? "")
        print("TRTTYTTWQ",model.videoTitle)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        player?.pause()
          player = nil
        


        
        
        
        videoContainer.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

    }
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(videoTapped))
        videoContainer.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func videoTapped() {
        delegate?.didTapVideoCell(self)
    }

    func togglePlayPauseIcon(isPlaying: Bool) {
        playIconImageView.isHidden = isPlaying
    }
    func setVideoMuted(_ isMuted: Bool) {
        player?.isMuted = isMuted
    }
    
    func togglePlayback() {
         if let player = player {
             if player.timeControlStatus == .playing {
                 player.pause()
                 playIconImageView.isHidden = false
             } else {
                 player.play()
                 playIconImageView.isHidden = true
             }
         }
     }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        
        adSubViews()
    }
    
    private func setupPlayIconImageView() {
           contentView.addSubview(playIconImageView)
           playIconImageView.frame = videoContainer.bounds
           playIconImageView.center = CGPoint(x: videoContainer.bounds.midX, y: videoContainer.bounds.midY)
       }

    
    func prepareVideo(urlString: String) {
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }

            preloadVideoContent(url: url)
        }

        private func preloadVideoContent(url: URL) {
            let asset = AVAsset(url: url)
            let keys = ["playable"]

            asset.loadValuesAsynchronously(forKeys: keys) {
                var error: NSError? = nil
                let status = asset.statusOfValue(forKey: "playable", error: &error)

                if status == .loaded {
                    DispatchQueue.main.async {
                        self.setupPlayer(with: asset)
                    }
                } else {
                    // Handle error
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }

        private func setupPlayer(with asset: AVAsset) {
            let playerItem = AVPlayerItem(asset: asset)
            self.player = AVPlayer(playerItem: playerItem)

            self.playerLayer = AVPlayerLayer(player: self.player)
            self.playerLayer?.frame = self.bounds
            self.playerLayer?.videoGravity = .resizeAspectFill

            if let playerLayer = self.playerLayer {
                self.videoContainer.layer.addSublayer(playerLayer)
            }
        }

    
    func adSubViews(){
        
               contentView.addSubview(videoContainer)
                contentView.addSubview(profileBtn)
                contentView.addSubview(userName)
                contentView.addSubview(descriptions)
                contentView.addSubview(buttonStackView)
        contentView.addSubview(profileBtnClicked)

               // like stack and comment stack
        
        likeStack.addArrangedSubview(likeBtn)
        likeStack.addArrangedSubview(likeLabel)
        
        commentStack.addArrangedSubview(commentBtn)
        commentStack.addArrangedSubview(commentLabel)
        

                // Add buttons to the stack view
                buttonStackView.addArrangedSubview(likeStack)
                buttonStackView.addArrangedSubview(commentStack)
                buttonStackView.addArrangedSubview(saveBtn)
                buttonStackView.addArrangedSubview(shareBtn)
        
        

        likeBtn.addTarget(self, action: #selector(didTapLikeButton), for: .touchDown)
        profileBtn.addTarget(self, action: #selector(didTapProfile), for: .touchDown)
        profileBtnClicked.addTarget(self, action: #selector(didTapProfile), for: .touchDown)

        shareBtn.addTarget(self, action: #selector(didTapShare), for: .touchDown)
        videoContainer.clipsToBounds = true
        contentView.sendSubviewToBack(videoContainer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        videoContainer.frame = contentView.bounds
        
        
        // Set the frame for the profile image on the left
            let profileImageY = contentView.bounds.height - 140  // Height of the tab bar, height of the image
            profileBtn.frame = CGRect(x: 10, y: profileImageY, width: 40, height: 40)
            profileBtn.layer.cornerRadius = profileBtn.bounds.width / 2

        
        
        
            // Set the frame for the username label to the right of the profile image
            userName.frame = CGRect(x: profileBtn.frame.maxX + 10, y: profileBtn.frame.origin.y, width: contentView.bounds.width - profileBtn.frame.maxX - 20, height: 20)
        let labelX = profileBtn.frame.maxX + 10

        profileBtnClicked.frame = CGRect(x: profileBtnClicked.frame.maxX + 10, y: profileBtnClicked.frame.origin.y, width: contentView.bounds.width - profileBtnClicked.frame.maxX - 20, height: 20)
    

        descriptions.frame = CGRect(x: labelX, y: userName.frame.maxY + 5, width: contentView.bounds.width - labelX - 20, height: 20)

            // Set the frame for the button stack on the right
        let buttonStackY = contentView.bounds.height - 140 // Height of the tab bar, height of the stack
            buttonStackView.frame = CGRect(x: contentView.bounds.width - 60, y: buttonStackY - 160, width: 50, height: 200)
        

    }



    @objc private func didTapLikeButton(){
        guard let model = model else {return}
        delegate?.didTapLikeBtn(with: model)
    }
    @objc private func didTapProfile(){
        guard let model = model else {return}
        delegate?.didProfileBtn(with: model)
                                
                                }
    @objc private func didTapShare(){
            guard let model = model else {return}
            delegate?.didShareBtn(with: model)
        }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func playerItemDidReachEnd(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
            player?.play()
        }
    }

    func startVideo() {
        player?.play()
    }

    func stopVideo() {
        player?.pause()
    }
}


struct VideoModel{
    var name:String
    var description:String
    var imageThumb:String
    var videoFileUrl:String
    var userName:String
    var userId:String
    var status:String
    var profileImage:String

}
