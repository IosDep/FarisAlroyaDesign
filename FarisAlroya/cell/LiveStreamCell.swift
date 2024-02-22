//
//  LiveStreamCell.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 16/01/2024.
//

import UIKit


import UIKit
import AVFoundation
import SDWebImage





class LiveStreamCell: UICollectionViewCell {
    var player:AVPlayer?
    
    
     let videoContainer = UIView()
    var model:NewAppendItItems?
    static let identfier = "LiveStreamCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupVideoContainer()
    }
    
    
     func setupVideoContainer() {
        videoContainer.layer.masksToBounds = true
        contentView.addSubview(videoContainer)
        contentView.sendSubviewToBack(videoContainer)
    }

    
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
    

    func configModel ( with model:LiveStreamModelArray){

        
     
//        self.model  = model
////
//        self.userName.text = model.userName
//        self.descriptions.text = model.videoDesc
////
//        if  model.userPic.isEmpty{
//            imageBtn.image = UIImage(named: "navlogo")
//        }else {
//            imageBtn.sd_setImage(with:(URL(string: model.userPic)), completed: { (image, error, cachType, url) in
//                if error == nil {
//                    self.imageBtn.image = image!
//
//                }
//            })
//        }


        
        

        
        setupPlayer(with: model.livestreamUrl ?? "")


    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        player?.pause()
          player = nil
        setVideoMuted(true)


        
        
        
        videoContainer.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

    }
    func setVideoMuted(_ isMuted: Bool) {
        player?.isMuted = isMuted
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        
        adSubViews()
    }
    func setupPlayer(with url: String) {
        guard let videoURL = URL(string: url) else { return }

        // Create an asset with the URL and add the token to the headers
        let asset = AVURLAsset(url: videoURL, options: ["AVURLAssetHTTPHeaderFieldsKey": ["Authorization": ServerConstants.BASE_URL_LIVE_STREAM_TOKEN]])
        let playerItem = AVPlayerItem(asset: asset)

        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)

        player = AVPlayer(playerItem: playerItem)

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = contentView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        videoContainer.layer.addSublayer(playerLayer)
    }

    
    func adSubViews(){
        
               contentView.addSubview(videoContainer)
//                contentView.addSubview(profileBtn)
//                contentView.addSubview(userName)
//                contentView.addSubview(descriptions)
//                contentView.addSubview(buttonStackView)
//
//               // like stack and comment stack
//
//        likeStack.addArrangedSubview(likeBtn)
//        likeStack.addArrangedSubview(likeLabel)
//
//        commentStack.addArrangedSubview(commentBtn)
//        commentStack.addArrangedSubview(commentLabel)
//
//
//                // Add buttons to the stack view
//                buttonStackView.addArrangedSubview(likeStack)
//                buttonStackView.addArrangedSubview(commentStack)
//                buttonStackView.addArrangedSubview(saveBtn)
//                buttonStackView.addArrangedSubview(shareBtn)
//
//
//
//        likeBtn.addTarget(self, action: #selector(didTapLikeButton), for: .touchDown)
//        profileBtn.addTarget(self, action: #selector(didTapProfile), for: .touchDown)
//        shareBtn.addTarget(self, action: #selector(didTapShare), for: .touchDown)
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

            // Set the frame for the button stack on the right
        let buttonStackY = contentView.bounds.height - 140 // Height of the tab bar, height of the stack
            buttonStackView.frame = CGRect(x: contentView.bounds.width - 60, y: buttonStackY - 160, width: 50, height: 200)
        

    }



//    @objc private func didTapLikeButton(){
//        guard let model = model else {return}
//        delegate?.didTapLikeBtn(with: model)
//    }
//    @objc private func didTapProfile(){
//        guard let model = model else {return}
//        delegate?.didProfileBtn(with: model)
//
//                                }
//    @objc private func didTapShare(){
//            guard let model = model else {return}
//            delegate?.didShareBtn(with: model)
//        }
//

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


