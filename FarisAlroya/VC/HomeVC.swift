//
//  HomeVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit
import AVFoundation

class HomeVC: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
   
    @IBOutlet weak var tableView: UITableView!
    
    var reels : [VideoReel] = []
    var index : Int?
    var player: AVPlayer?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        tableView.rowHeight = UITableView.automaticDimension

    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return reels.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeCell
        
        if let index = self.index {
            
            if let video = URL(string: reels[index].videoURL ?? "") {
                
                player = AVPlayer(url: video)
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = cell?.videoPlayerView.bounds ?? CGRect(x: 0, y: 0, width: 600, height: 600)
                cell?.videoPlayerView.layer.addSublayer(playerLayer)
                player?.play()
                
            }
        }
        
        
        cell?.frame.size.width = tableView.bounds.width
        
        return cell!
                
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.bounds.height
    }

}
