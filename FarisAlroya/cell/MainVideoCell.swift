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


}


class MainVideoCell: UICollectionViewCell {
    var player:AVPlayer?
    private let videoContainer = UIView()
    var model:NewAppendItItems?
    static let identfier = "MainVideoCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
   private let userName:UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.textColor = .white
return lbl
   }()
    
    private let descriptions:UILabel = {
         let lbl = UILabel()
         lbl.textAlignment = .left
         lbl.textColor = .white
        
 return lbl
    }()
    
    
    private let profileButton:UIButton = {
         let button = UIButton()
        button.setBackgroundImage (UIImage (systemName: "person.circle"), for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        return button
 
    }()
    
    private let imageBtn:UIImageView = {
         let button = UIImageView()
        return button
 
    }()
    
    
    private let likeBtn:UIButton = {
         let button = UIButton()
//        button.setBackgroundImage (UIImage (systemName: "heart.fill"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)

        return button
 
    }()
    
    private let commentBtn:UIButton = {
         let button = UIButton()
        button.setImage(UIImage(named: "comment"), for: .normal)

        return button
 
    }()
    
    private let saveBtn:UIButton = {
         let button = UIButton()
//        button.setBackgroundImage (UIImage (systemName: "heart.fill"), for: .normal)
        button.setImage(UIImage(named: "save" ), for: .normal)

        return button
 
    }()
    
    private let shareBtn:UIButton = {
        
        let button = UIButton()
//        button.setBackgroundImage (UIImage (systemName: "heart.fill"), for: .normal)
       button.setImage(UIImage(named: "share 1" ), for: .normal)

       return button
 
    }()
    
    weak var delegate:MainVideoDelegate?
    
    func config(with model:VideoModel){
      
//        self.configModel(model: model)
     
    }
    
    func configModel ( with model:NewAppendItItems){

//        guard let path = Bundle.main.path(forResource: "test", ofType: "mp4")else{
//            print("EERRRorVideo")
//            return
//        }
//        player = AVPlayer(url: URL(fileURLWithPath: path))
//
//
//        let playerView = AVPlayerLayer()
//        playerView.player = player
//        playerView.videoGravity = .resizeAspectFill
//        playerView.frame = contentView.bounds
//        player?.volume = 0
//        player?.play()
        
     
        self.model  = model
        
        self.userName.text = model.userName
        self.descriptions.text = model.videoDesc
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

//        let playerItem = AVPlayerItem(url: URL(string: model.videoUrl)!)
//        player = AVPlayer(playerItem: playerItem)
//
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = contentView.bounds
//        playerLayer.videoGravity = .resizeAspectFill
//        videoContainer.layer.addSublayer(playerLayer)
//
//        player?.play()
        setupPlayer(with: model.videoUrl)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        player?.pause()
          player = nil
        setVideoMuted(true)

//          userName.text = nil
          descriptions.text = nil
        
        videoContainer.layer.sublayers?.forEach { $0.removeFromSuperlayer() }

    }
    func setVideoMuted(_ isMuted: Bool) {
        player?.isMuted = isMuted
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        adSubViews()
    }
    private func setupPlayer(with url: String) {
        let playerItem = AVPlayerItem(url: URL(string: url)!)
              NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
              player = AVPlayer(playerItem: playerItem)

              let playerLayer = AVPlayerLayer(player: player)
              playerLayer.frame = contentView.bounds
              playerLayer.videoGravity = .resizeAspectFill
              videoContainer.layer.addSublayer(playerLayer)
    }
    func adSubViews(){
        
        contentView.addSubview(videoContainer)
        contentView.addSubview(userName)
        contentView.addSubview(descriptions)
        contentView.addSubview(likeBtn)
        contentView.addSubview(commentBtn)
        contentView.addSubview(saveBtn)
        contentView.addSubview(shareBtn)
        
        

        likeBtn.addTarget(self, action: #selector(didTapLikeButton), for: .touchDown)
        profileButton.addTarget(self, action: #selector(didTapProfile), for: .touchDown)
        shareBtn.addTarget(self, action: #selector(didTapShare), for: .touchDown)
        videoContainer.clipsToBounds = true
        contentView.sendSubviewToBack(videoContainer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        videoContainer.frame = contentView.bounds

        let buttonSize: CGFloat = 40 // Size for profile and share buttons
        let buttonSpacing: CGFloat = 20 // Spacing between buttons
        let labelHeight: CGFloat = 20 // Height of the userName label
        let bottomMargin: CGFloat = 190 // Bottom margin for the buttons

        // Calculate the y position for the buttons
        let buttonY = contentView.bounds.height - bottomMargin - buttonSize

        // Position Profile Button and Image Button at the bottom left
        profileButton.frame = CGRect(x: buttonSpacing, y: buttonY, width: buttonSize, height: buttonSize)
        imageBtn.frame = profileButton.frame // Same position as profileButton

        // Position Share Button above the profile and image buttons
        shareBtn.frame = CGRect(x: buttonSpacing, y: buttonY - buttonSpacing - buttonSize, width: buttonSize, height: buttonSize)

        // Position Username Label to take full width and align with share button
        userName.frame = CGRect(x: 65, y: profileButton.frame.minY + 15, width: contentView.bounds.width, height: labelHeight)
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
