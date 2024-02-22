//
//  SceneDelegate.swift
//  FarisAlroya
//
//  Created by Blue Ray on 08/11/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        if let incomingURL = userActivity?.webpageURL {
            handleIncomingURL(url: incomingURL)
        }

    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }

        // Parse the URL and extract the path or parameters you need
        let path = url.path

        // Assuming your URL might look like "com.ob.Kanz://video/123"
        if path.contains("/video/") {
            let videoID = path.replacingOccurrences(of: "/video/", with: "")
            
            // Now navigate to the specific page in your app
            // This example assumes you have a method to handle the navigation
            navigateToVideoPage(withID: videoID)
        }
    }

    func navigateToVideoPage(withID videoID: String) {
        // Logic to navigate to the video page
        // This might involve setting the rootViewController of the window
        // or pushing a new view controller onto a navigation stack
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "OneVideoPlay") as! OneVideoPlay
    
        vc.videoPlay = videoID
   

//            self.navigationController?.pushViewController(vc, animated: true)
    
        self.window?.rootViewController = vc

        
    }


    
    func handleIncomingURL(url: URL) {
        let urlString = url.absoluteString
        guard let urlComponents = URLComponents(string: urlString),
              let scheme = urlComponents.scheme,
              scheme == "com.ob.Kanz",
              let host = urlComponents.host,
              host == "videos",
              let videoID = urlComponents.path.components(separatedBy: "/").last else {
            return
        }
        
        // Now you have the videoID, navigate to the appropriate screen in your app
        print("Open video with ID: \(videoID)")
        // Implement navigation to the video based on your app's structure
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

