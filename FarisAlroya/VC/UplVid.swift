//
//  UplVid.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 17/01/2024.

import UIKit
import Alamofire
    import Lottie
import AVFoundation
import JGProgressHUD
import Photos
import MobileCoreServices

class UplVid: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var videoURL: URL?

    @IBOutlet weak var vid_img: UIImageView!
    @IBOutlet weak var collection: UICollectionView!

            @IBOutlet weak var placeHolderView: UIView!

            @IBOutlet weak var upl_image: LottieAnimationView!

            static var activities : [String] = []
            var activitiesHolder : [ActivityHolder] = []

            @IBOutlet weak var nameVid: UITextField!

        
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.


        
        upl_image.play()
        upl_image.loopMode = .loop
        
        collection.dataSource = self
        collection.delegate = self
        
        
        collection.register(UINib(nibName: "ActivitiesCell", bundle: nil), forCellWithReuseIdentifier: "ActivitiesCell")
        
        getActivities()
        
        
        
        self.makeShadow(mainView: placeHolderView)
        self.makeShadow(mainView: upl_image)

        


    }
    

    @IBAction func doActionUpload(_ sender: UIButton) {
        guard let videoURL = self.videoURL else {
            
            self.showErrorHud(msg: "يرجى اختيار او تصوير مقطع")
            return
        }

        uploadVideo(videoURL: videoURL, additionalParams: ["description": self.nameVid.text ?? ""]) // Replace with actual parameters
    }

    func uploadVideo(videoURL: URL, additionalParams: [String: String]) {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "جاري الرفع"
        hud.show(in: self.view)
        
        let uploadURL = ServerConstants.BASE_URL + "/user/uploadVideoOrImage"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Helper.shared.getUserToken() ?? "")",
            "Content-type": "multipart/form-data"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(videoURL, withName: "file", fileName: "video.mp4", mimeType: "video/mp4")
            additionalParams.forEach { key, value in
                multipartFormData.append(Data(value.utf8), withName: key)
            }
        }, to: uploadURL, headers: headers).responseJSON { response in
            hud.dismiss()
            switch response.result {
            case .success(let value):
                print("Upload Success: \(value)")
                self.showSuccessHud(msg: "تم تحميل المقطع بنجاح بانتظار معالجة الفيديو")
                self.dismiss(animated: true)
            case .failure(let error):
                print("Upload Error: \(error)")
                self.showErrorHud(msg: "Upload Error: \(error.localizedDescription)")
            }
        }
    }

    @IBAction func reachVideos(_ sender: UIButton) {
        presentMediaOptions()


        
    }
        
        
    
        @IBAction func close(_ sender: Any) {
            self.dismiss(animated: true)
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return activitiesHolder.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                        
                let cell = self.collection.dequeueReusableCell(withReuseIdentifier: "ActivitiesCell", for: indexPath) as? ActivitiesCell
            let activity = activitiesHolder[indexPath.row]

            cell?.selectedBtn.isHidden = !activity.selected
            cell?.mainView.backgroundColor = activity.selected ? UIColor(red: 0.85, green: 0.94, blue: 1.00, alpha: 1.00) : UIColor.clear // Or your default color

            cell?.activityLabel.text = activitiesHolder[indexPath.row].activitty.name ?? ""
                    
            let labelSize = cell?.activityLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: cell?.activityLabel.frame.size.height ?? 50.0))

                // Update cell width constraint based on label size
            cell?.contentView.frame.size.width = (labelSize?.width ?? 100.0)  + 10.0 ?? 150.0
                    
                
                return cell!
                
                
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            if activitiesHolder[indexPath.row].selected  == false {
                
                activitiesHolder[indexPath.row].selected  = true
                
                ActivitiesVC.activities.append(activitiesHolder[indexPath.row].activitty.id ?? 0)

            }
            
            else {
                activitiesHolder[indexPath.row].selected = false
            }
            
            self.collection.reloadItems(at: [indexPath])

        }
        
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

             // collectionView.bounds.height
            let h = 30.0
            let w = collectionView.bounds.width / 20

            return CGSize(width: w, height: h)

        }
        
        
        
    func presentMediaOptions() {
        let alert = UIAlertController(title: "اختيار مقطع", message: nil, preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "اختيار من المعرض", style: .default, handler: { _ in
            self.requestPhotoLibraryPermission()
        }))

        alert.addAction(UIAlertAction(title: "تصوير مقطع", style: .default, handler: { _ in
            self.requestCameraPermission()
        }))

        alert.addAction(UIAlertAction(title: "الغاء", style: .cancel, handler: nil))
        // Configure popover controller for iPad
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view // The view containing the anchor rectangle for the popover.
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // The rectangle in the specified view in which to anchor the popover.
            popoverController.permittedArrowDirections = [] // Optional: Arrow directions for the popover.
        }
        present(alert, animated: true)
    }

    func requestPhotoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                if status == .authorized {
                    self.showImagePicker(sourceType: .photoLibrary)
                } else {
                    // Handle the case of no permission
                    self.showErrorHud(msg: "لم يتم اعطاء صلاحية للوصول الى المعرض")
                }
            }
        }
    }

    func requestCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted {
                    self.showImagePicker(sourceType: .camera)
                } else {
                    // Handle the case of no permission
                    self.showErrorHud(msg: "لم يتم اعطاء صلاحية للوصول الى الكاميرا")

                }
            }
        }
    }

    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.mediaTypes = ["public.movie"] // Ensure this is set correctly
        picker.delegate = self
        present(picker, animated: true)
    }
    
    

    func displayThumbnail(url: URL) {
        let asset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTimeMake(value: 1, timescale: 2)
        if let cgImage = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil) {
            var thumbnail = UIImage(cgImage: cgImage)

            // If you want to add an overlay (like a hand icon), you can do it here
            // Example: thumbnail = addOverlayToThumbnail(thumbnail)

            self.upl_image.isHidden = true
            vid_img.image = thumbnail
        }
    }

    // Example function to add overlay
    func addOverlayToThumbnail(_ thumbnail: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(thumbnail.size, false, 0)
        thumbnail.draw(at: CGPoint.zero)
        
        // Draw your overlay image here
        let overlayImage = UIImage(named: "logo") // Replace with your overlay image
        overlayImage?.draw(at: CGPoint(x: (thumbnail.size.width - overlayImage!.size.width) / 2, y: (thumbnail.size.height - overlayImage!.size.height) / 2))
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return finalImage ?? thumbnail
    }


 


//            // UIImagePickerControllerDelegate Methods
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let url = info[.mediaURL] as? URL {
//            self.videoURL = url
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }

        
     
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)

        guard let mediaType = info[.mediaType] as? String,
              mediaType == kUTTypeMovie as String,
              let videoURL = info[.mediaURL] as? URL else {
            return
        }

        displayThumbnail(url: videoURL)

        sendVideoToServer(videoURL)
    }
        
    func sendVideoToServer(_ videoURL: URL) {
        print("Video saved at: \(videoURL)")

        convertMOVtoMP4AndUpload(videoURL)
    }

    private func convertMOVtoMP4AndUpload(_ videoURL: URL) {
        let outputURL = generateOutputURL()

        convertMOVtoMP4(inputURL: videoURL, outputURL: outputURL) { [weak self] convertedURL in
            if let convertedURL = convertedURL {
                print("Converted Video saved at: \(convertedURL)")

                self?.videoURL = convertedURL
            } else {
                print("Failed to convert video for URL: \(videoURL)")
            }
        }
    }
    
    private func convertMOVtoMP4(inputURL: URL, outputURL: URL, completion: @escaping (URL?) -> Void) {
        let asset = AVURLAsset(url: inputURL)
        guard let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetPassthrough) else {
            completion(nil)
            return
        }

        exportSession.outputFileType = .mp4
        exportSession.outputURL = outputURL

        exportSession.exportAsynchronously {
            switch exportSession.status {
            case .completed:
                completion(outputURL)
            default:
                completion(nil)
            }
        }
    }

    private func generateOutputURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let uniqueFilename = UUID().uuidString
        return documentsDirectory.appendingPathComponent("\(uniqueFilename).mp4")
    }
    
    func getActivities() {

        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        let link = ServerConstants.BASE_URL  + "/frontend/getHashtags"

     
            
        AF.request(link, method: .post).response { (response) in
            if response.error == nil {
                do {
                    
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    print("SDKajd","\(jsonObj)")
                    if jsonObj != nil {
                        hud.dismiss()
                        if let obj = jsonObj!["msg"] as? [String:Any] {
                            let  status = obj["status"] as? Int
                            let  message = obj["message"] as? String
                            
                            print("SDKajd123","\(obj)")

                            
                            if status == 200 {
                                
//

                                
                                if let data = jsonObj!["results"] as? [[String: Any]] {
                                                                   
                                        
                                    for i in data{
                                        let model = ActivitiesModel(data: i)
                                        self.activitiesHolder.append(ActivityHolder(activitty: model, selected: false))
                                    }
                                    self.collection.reloadData()
                                    
                                    
                             
                                }
                                
                                
                            } else {
                                if let obj = jsonObj!["msg"] as? [String:Any] {
                                    
                                    //
                                    if let msg = obj["message"] as? String {
                                        
                                        self.showWarningHud(msg: msg ?? "", hud: hud)
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
    @IBAction func draft(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
