//
//  LiveStreamListVC.swift
//  KEENZALARAB
//
//  Created by Osama Abu hdba on 29/01/2024.
//

import UIKit
import ZegoExpressEngine
import ZegoUIKit
import ZegoUIKitPrebuiltLiveStreaming
import ZegoUIKitSignalingPlugin
import JGProgressHUD
import Alamofire
class LiveStreamListVC: BaseViewController, ZegoEventHandler {

    let appID: UInt32 = 1099604494
    let appSign: String = "f192aaef99c7b160abbee0fce1675ff31ed5d4a0802a6e7051945687ab8f9fb6"
    let userId: String = String(format: "%d", arc4random() % 999999)
    var userName: String?
    var ourRoomId: String?

    @IBOutlet weak var roomId: UITextField!

    // Initialize your custom event handler only once
    var eventHandler: ZegoEventHandler!

    override func viewDidLoad() {
        super.viewDidLoad()
//        createEngine()

        self.userName = String(format: "n_%@", Helper.shared.getUsername() ?? "")

        VideoPlayerController.sharedVideoPlayer.pauseCurrentVideo()

    }

    deinit{
        ZegoExpressEngine.shared().logoutRoom()
        ZegoExpressEngine.shared().setEventHandler(nil)
    }

    @IBAction func joinLiveClick(_ sender: UIButton) {
        self.createRoom()

    }

    
    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted {
                    self.createRoom()

                } else {
                    // Handle the case of no permission
                    self.showErrorHud(msg: "لم يتم اعطاء صلاحية للوصول الى الكاميرا")

                }
            }
        }
    }

    @IBAction func watchLive(_ sender: Any) {
        requestCameraPermission()
    }

    func joinLiveAsHost(roomID: String) {
        let config: ZegoUIKitPrebuiltLiveStreamingConfig = ZegoUIKitPrebuiltLiveStreamingConfig.host(enableSignalingPlugin: true)
        let audioVideoConfig = ZegoPrebuiltAudioVideoViewConfig()
        audioVideoConfig.useVideoViewAspectFill = true
        config.enableCoHosting = true
        config.audioVideoViewConfig = audioVideoConfig
        let liveVC: ZegoUIKitPrebuiltLiveStreamingVC = ZegoUIKitPrebuiltLiveStreamingVC(self.appID, appSign: self.appSign, userID: self.userId , userName: self.userName ?? "", liveID: roomID, config: config)
        liveVC.modalPresentationStyle = .fullScreen
        self.present(liveVC, animated: true, completion: nil)
    }

    func joinLiveAsAudience(roomID: String) {
        let config: ZegoUIKitPrebuiltLiveStreamingConfig = ZegoUIKitPrebuiltLiveStreamingConfig.audience(enableSignalingPlugin: true)
        let audioVideoConfig = ZegoPrebuiltAudioVideoViewConfig()
        audioVideoConfig.useVideoViewAspectFill = true
        config.enableCoHosting = true
        config.audioVideoViewConfig = audioVideoConfig
        let liveVC: ZegoUIKitPrebuiltLiveStreamingVC = ZegoUIKitPrebuiltLiveStreamingVC(self.appID, appSign: self.appSign, userID: self.userId , userName: self.userName ?? "", liveID: roomID, config: config)
        liveVC.modalPresentationStyle = .fullScreen
        self.present(liveVC, animated: true, completion: nil)
    }

    func createEngine() {
        let profile = ZegoEngineProfile()
        profile.appID = appID
        profile.appSign = appSign
        profile.scenario = .broadcast

        // Initialize the event handler only once
        eventHandler = self

        // Create ZegoExpressEngine with the initialized event handler
        ZegoExpressEngine.createEngine(with: profile, eventHandler: eventHandler)

        print("ZegoExpressEngine created successfully")
    }

    // Implement required methods of ZegoEventHandler protocol here
    func onRoomStateUpdate(_ state: ZegoRoomState, errorCode: Int32, extendedData: [AnyHashable : Any]?, roomID: String?) {
        // Handle room state updates
        print("Room State Update: \(state.rawValue), errorCode: \(errorCode)")
    }

    // Add other required methods as needed

    private func destroyEngine() {
        ZegoExpressEngine.destroy(nil)
    }
    @IBAction func closed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func createRoom(){
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        let link = URL(string: ServerConstants.BASE_URL  + "/user/createOrStopLiveStreaming")
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Helper.shared.getUserToken() ?? "")",
          ]
            
        AF.request(link!, method: .post,headers: headers).response { (response) in
            if response.error == nil {
                do {
                    
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    if jsonObj != nil {
                        
                        if let obj = jsonObj!["status"] as? [String:Any] {
                            let  status = obj["code"] as? Int
                            let  message = obj["message"] as? String
                            
                            
                            
                            if status == 200 {
                                
                                self.show(message: message ?? "", messageType: .success)
                                
                                
                                hud.dismiss()
                                
                                
                                if message == "تم إيقاف البث المباشر بنجاح" {
                                    self.createRoom()

                                }else {
                                    if let data = jsonObj!["results"] as? [String: Any] {
                                        
                                        
                                        if let room_id = data["room_id"] as? String {
                                            print("room_id",room_id)
                                            
                                            self.ourRoomId  = room_id
                                            

                                                self.joinLiveAsHost(roomID: room_id)
                                                
                                            print("room_i122d",self.removeHyphens(from: room_id))

                                            
                                        }
                                        
                                        if let id = data["id"] as? Int {
                                            print("Id",id)
                                            
                                            
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                }}
                                else {
                                    //                                self.showWarningHud(msg: msg ?? "", hud: hud)
                                    hud.dismiss()
                                    if let obj = jsonObj!["msg"] as? [String:Any] {
                                        
                                        //
                                        if let msg = obj["message"] as? String {
                                            self.show(message: message ?? "", messageType: .failure)
                                            
                                            //    self.showWarningHud(msg: msg ?? "", hud: hud)
                                        }
                                        
                                    }
                                }
                            }
                            
                        
                    }
                }
            
                    
                 catch let err as NSError {
                    print("Error: \(err)")
                     hud.dismiss()
//                    self.serverError(hud: hud)
                }
            } else {
                print("Error")
                hud.dismiss()

//                self.serverError(hud: hud)
                
                
            }
        }
        
    }
}
