//
//  AppDelegate.swift
//  FarisAlroya
//
//  Created by Blue Ray on 08/11/2023.
//

import UIKit
import MOLH

import SendbirdLiveSDK
import SendbirdUIKit
import SendbirdChatSDK
import netfox
import Alamofire
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        
        
        MOLHLanguage.setDefaultLanguage("ar")
        MOLH.shared.activate(false)
        

        //        Disable dark mode
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        // Override point for customization after application launch.
        self.setupLogging()
        self.setUpNetworkInterceptor()
        MOLHLanguage.setDefaultLanguage("ar")
        MOLH.shared.activate(false)
//        self.updateViewCont()
//        self.updateViewCont()
        let tok = Helper.shared.getUserToken() ?? "-"
        let isGust = Helper.shared.getUserTokenForGuest() ?? ""
        
        print(tok,"token")
        print(isGust,"isGuest")
        
        if isGust == "1" {
            self.notLogin()
        } else {
            if tok != "-" && !tok.isEmpty {
                self.isLogin()
            } else {
                self.notLogin()
            }
        }
        
        print("dbaksjld",Helper.shared.getUserToken())
        
        
        

        return true
    }
    
    
  
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
           let incomingURL = userActivity.webpageURL {
            print("Deep link URL: \(incomingURL)")
//            handleDeepLinkURL(incomingURL)
            return true
        }
        return false
    }

//    func handleDeepLinkURL(_ url: URL) {
//        // Parse the URL to determine which page to open
//        // This is a simple example. You'll need to adjust it based on your URL structure
//        let pathComponents = url.pathComponents
//        if pathComponents.contains("video"), let videoID = pathComponents.last {
//            // Assuming the videoID is at the end of the path, navigate to the video player page
//            DispatchQueue.main.async { [weak self] in1
//                self?.navigateToVideoPlayer(withVideoID: videoID)
//            }
//        }
//        // Add more conditions as needed based on your URL structure and app's navigation requirements
//    }

    func navigateToVideoPlayer(withVideoID videoID: String) {
        // Create and display the video player view controller with the given videoID
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let videoPlayerVC = storyboard.instantiateViewController(withIdentifier: "OneVideoPlay") as? OneVideoPlay {
//            // Pass the videoID or videoURL to the view controller
//            videoPlayerVC.videoPlay = videoID // Make sure YourVideoPlayerViewControllerClass has a `videoID` property or a method to configure it
//
//            // Set the video player as the root view controller or push it to the navigation stack as needed
//            window?.rootViewController = videoPlayerVC
//            window?.makeKeyAndVisible()
//        }
        notLogin()
    }

    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let scheme = url.scheme,
           scheme.localizedCaseInsensitiveCompare("com.kanz") == .orderedSame,
           let view = url.host {
            
            var parameters: [String: String] = [:]
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
            print("HERRRREEEEEE")
            
        }
        return true
    }
    func signIn(appId: String, userId: String, accessToken: String?) {
        SBUGlobals.currentUser = .init(userId: "5")
        SBUGlobals.accessToken = ""
        SBUGlobals.applicationId = "463780EA-658F-4CC7-B3D3-B9EC3401C650"
        SBUTheme.set(theme: .dark)
        
        
        // Update app ID
        SendbirdLive.initialize(params: .init(applicationId: "463780EA-658F-4CC7-B3D3-B9EC3401C650"), migrationStartHandler: nil, completionHandler: { _ in
            SendbirdLive.setLogLevel(.verbose)
            SendbirdLive.executeOn(.main)
            SendbirdLive.authenticate(userId: userId) { result in
                let params = UserUpdateParams()
                params.nickname = userId
                SendbirdChat.updateCurrentUserInfo(params: params)
                
                SendbirdUI.connect { _, error in
                    DispatchQueue.main.async {
                        
                        
                        switch result {
                        case .success:
                            UserDefaults.standard.set(userId, forKey: "userId")
                            UserDefaults.standard.set(accessToken, forKey: "accessToken")
                            UserDefaults.standard.set(appId, forKey: "applicationId")
                            
                        case .failure(let error):
                            print("Errors",error.localizedDescription)
                            //                            self.presentErrorAlert(message: error.localizedDescription)
                        }
                    }
                }
            }
        })
        
    }
    
    
    func guestLogin() {
        signIn(appId: "463780EA-658F-4CC7-B3D3-B9EC3401C650", userId: "12", accessToken: "")

        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "VidViewController") as? VidViewController
        vc?.isGust  = 1
        self.window?.rootViewController = vc
        
        
        
        
    }

    
    func isLogin() {
     

        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CustomTabBarController")
        self.window?.rootViewController = vc
        
        
        
    }
 
    func notLogin() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "loginv")
        self.window?.rootViewController = vc
        print("dbaksjld",Helper.shared.getUserToken())
        Helper.shared.saveUserToken(user_picture: "-")


    }
    
    
    func updateView() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UpdateVeiwControllelr")
        self.window?.rootViewController = vc
        
        
        
//        print("dbaksjld",Helper.shared.getUserToken())
//        Helper.shared.saveUserToken(user_picture: "-")


    }
    
    func creteAccont() {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PersonalInfoVC")
        self.window?.rootViewController = vc
    }



    
}



extension AppDelegate {
    func setupLogging() {
#if DEBUG
//        NetworkActivityLogger.shared.level = .debug
//        NetworkActivityLogger.shared.startLogging()
#endif
    }
    private func setUpNetworkInterceptor() {
        
            NFX.sharedInstance().start()
        
    }
}
