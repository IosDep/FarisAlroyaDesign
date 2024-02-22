import UIKit
import AVFoundation

class OneVideoPlay: UIViewController {
    
    @IBOutlet weak var videoPlays: UIView!
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var videoPlay  = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assuming you have the video URL
        if let videoURL = URL(string: videoPlay) {
            // Initialize the AVPlayer with the video URL
            player = AVPlayer(url: videoURL)
            
            // Create an AVPlayerLayer
            playerLayer = AVPlayerLayer(player: player)
            
            // Optional: Configure the player layer's frame and other properties
            playerLayer?.frame = self.videoPlays.bounds
            playerLayer?.videoGravity = .resizeAspect // Adjust as needed
            
            // Add the player layer to your view's layer
            if let playerLayer = self.playerLayer {
                self.videoPlays.layer.addSublayer(playerLayer)
            }
            
            // Play the video
            player?.play()
        }
    }
    
    // Make sure to update the player layer's frame if the view's layout changes (e.g., device rotation)
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = videoPlays.bounds
    }
    
    // Clean up: Stop the player when the view controller is deinitialized or when it's appropriate
    deinit {
        player?.pause()
        player = nil
    }
}
