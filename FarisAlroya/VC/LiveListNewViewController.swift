    //
    //  LiveListNewViewController.swift
    //  FarisAlroya
    //
    //  Created by MOHAMMED JABER on 04/02/2024.
    //

    import UIKit
    import ZegoUIKit
    import ZegoUIKitPrebuiltLiveStreaming

    class LiveListNewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

        var viewModel = MainViewModel()

        let appID: UInt32 = 1099604494
        let appSign: String = "f192aaef99c7b160abbee0fce1675ff31ed5d4a0802a6e7051945687ab8f9fb6"
        let userId: String = String(format: "%d", arc4random() % 999999)
        var userName: String?
        var refreshControl: UIRefreshControl!

        @IBOutlet weak var tableView: UITableView!
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            VideoPlayerController.sharedVideoPlayer.pauseCurrentVideo()

        }
        override func viewDidLoad() {
            super.viewDidLoad()
            
            VideoPlayerController.sharedVideoPlayer.pauseCurrentVideo()


            refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
            self.tableView.addSubview(refreshControl)
            
            tableView.delegate =  self
            tableView.dataSource  = self
            self.tableView.register(UINib(nibName: "LiveVideoTabelView", bundle: nil), forCellReuseIdentifier: "LiveVideoTabelView")
            getAllLive()
            self.userName = String(format: "n_%@", Helper.shared.getUsername() ?? "")
            self.configureTableView()
         
            // Do any additional setup after loading the view.
        }
        
        @objc func didPullToRefresh() {
            self.viewModel.allLiveStream.removeAll()
            self.tableView.reloadData()
            self.getAllLive()
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            self.tableView.frame.height
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            self.viewModel.allLiveStream.count
        }
        
        
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            
            
            
            
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "LiveVideoTabelView", for: indexPath) as? LiveVideoTabelView
            
            let data  = self.viewModel.allLiveStream[indexPath.row]
//            print("dasdksad",data.user_image)
//            if  data.user_image == nil{
//                cell?.imagUser.image = UIImage(named: "navlogo")
//            }else {
            
            
            cell?.lblUserName.text =   "يبث الان " +  (data.user_name ?? "")  
 
            print("QEWEqwEQEWQ",data.user_image ?? "")
                cell?.imagUser.sd_setImage(with:(URL(string: data.user_image ?? "")), completed: { (image, error, cachType, url) in
                    if error == nil {
                        cell?.imagUser.image = image!
                        
                    }else {
                        cell?.imagUser.image = UIImage(named: "placeHolders")

                    }
                })
//            }
            
            
            return cell!
        }
        
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DFGHJK",self.viewModel.allLiveStream[indexPath.row].room_id ?? "")
            self.joinLiveAsAudience(roomID: self.viewModel.allLiveStream[indexPath.row].room_id ?? "")
            
            
            
            
        }
        func joinLiveAsAudience(roomID: String) {
            let config: ZegoUIKitPrebuiltLiveStreamingConfig = ZegoUIKitPrebuiltLiveStreamingConfig.audience(enableSignalingPlugin: true)
            let audioVideoConfig = ZegoPrebuiltAudioVideoViewConfig()
            audioVideoConfig.useVideoViewAspectFill = true
            config.enableCoHosting = true
            config.audioVideoViewConfig = audioVideoConfig
            
            let liveVC: ZegoUIKitPrebuiltLiveStreamingVC = ZegoUIKitPrebuiltLiveStreamingVC(self.appID, appSign: self.appSign, userID: self.userId, userName: self.userName ?? "", liveID: roomID, config: config)
            liveVC.modalPresentationStyle = .fullScreen
            self.present(liveVC, animated: true, completion: nil)
        }

        private func getAllLive() {

            self.refreshControl.endRefreshing()
            viewModel.getAllLiveStream() { [weak self] success, error in
                    if success {
                        // Update your UI with the results
                        // For example, reload a table view or collection view
                        self?.tableView.isHidden  =  false

                        self?.tableView.reloadData()
                        
     
                        
                    } else if let error = error {
                        // Handle the error, maybe show an alert to the user
                        print("Error occurred during search: \(error.localizedDescription)")
             

                    }
                }
            }

        
        fileprivate func configureTableView() {
            tableView.isPagingEnabled = true
            tableView.bounces = false
            tableView.showsVerticalScrollIndicator = false
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
            
        }

        
    }
