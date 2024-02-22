//
//  AccountSettingsVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit
import JGProgressHUD
import Alamofire
import AVFoundation
import Lottie
import Kingfisher

class AccountSettingsVC: UIViewController,UINavigationControllerDelegate ,UIImagePickerControllerDelegate{

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var usernameField: DesignableTextFeild!
    @IBOutlet weak var passwordField: DesignableTextFeild!
    @IBOutlet weak var nationalityField: DesignableTextFeild!
    @IBOutlet weak var ageField: DesignableTextFeild!
    @IBOutlet weak var countryField: DesignableTextFeild!
    @IBOutlet weak var emailField: DesignableTextFeild!
    @IBOutlet weak var phonenumField: DesignableTextFeild!
    
    var imagePicker = UIImagePickerController()
    var img: UIImage?
    var anim: LottieAnimationView!
    var userts =  [UserProfile]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 30
        imagePicker.delegate = self
        
        anim = LottieAnimationView(name: "watings") // Replace "animationName" with your animation file's name

           // Set the frame or use Auto Layout constraints
           anim.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
           anim.center = self.view.center

           // Configure animation properties
           
           anim.loopMode = .loop

           // Add it to your view
           self.view.addSubview(anim)

           // Start playing the animation
           anim.play()
        
        self.getUserInfo()
        


    }

    @IBAction func dismisss(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func changePasswordPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CreatePassVC") as! CreatePassVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    
    @IBAction func logouts(_ sender: Any) {
        
        Helper.shared.saveId(id: "0")
        Helper.shared.saveUserToken(user_picture: "")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.notLogin()
        
    }
    
    
    @IBAction func uploadImage(_ sender: Any) {
        
        let alert = UIAlertController(title: "choose photo from", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "photo library", style: .default, handler: { _ in
            self.openGallary()
        }))

        alert.addAction(UIAlertAction.init(title: "cancel", style: .cancel, handler: nil))

        /*If you want work actionsheet on ipad
        then you have to use popoverPresentationController to present the actionsheet,
        otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as! UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }

        self.present(alert, animated: true, completion: nil)
    }
    
   func openCamera()
    
    {
        self.checkCamera()
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        
        else
        {
            let alert  = UIAlertController(title: "Privacy Settings", message: "Go to privacy from setting to access photo library", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkCamera() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        
        switch authStatus {
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    // Access to the camera has been granted.
                    // You can perform camera-related tasks here.
                } else {
                    // Access to the camera has been denied.
                    // You can show an alert or take appropriate action.
                    let alert = UIAlertController(title: "Privacy Settings", message: "Camera access has been denied. Go to settings to grant access.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        case .denied:
            let alert = UIAlertController(title: "Privacy Settings", message: "Go to privacy settings to access the camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        default:
            print("Camera access status: \(authStatus)")
        }
    }


    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.mediaTypes = ["public.image"]
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.editedImage] as? UIImage {
//            self.userImg.image = image
            self.img = image
            self.profileImage.image = image

        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            self.userImg.image = image
            self.img = image
            self.profileImage.image = image

        }

    }
    
//
//    func getProfileInfo(){
//
//
//        let link = URL(string: "http://faris-alroya.com.dedi5536.your-server.de/en/app/user-info?uid=65")
//
//        let param :[String:Any] = [
//            "uid" :  "65"
//
//        ]
//
//        // Helper.shared.getId() ??
//
//
//        AF.request(link!, method: .get, parameters: param).response { (response) in
//            if response.error == nil {
//                do {
//                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
//
//                    if jsonObj != nil {
//
//                        if let  {
//
//
////                            self.showSuccessHud(msg: message ?? "", hud: hud)
//                if status == 200 {
//
//                    if let data = jsonObj!["data"] as? [String: Any] {
//
//
//
//                        let username = data["username"] as? String
//
//                        self.usernameField.text = username ?? ""
//
//                        let phone_number = data["phone_number"] as? String
//                        self.phonenumField.text = phone_number  ?? ""
//
//                        let mail = data["mail"] as? String
//                        self.emailField.text = mail ?? ""
//
//
//
//                        if  let profile_data = data["profile_data"] as? [String : Any] {
//
//                            let first_name = data["first_name"] as? String
//                            let last_name = data["last_name"] as? String
//                            let band_name = data["band_name"] as? String
//
//
//                        }
//
//
//
//                                DispatchQueue.main.async {
//
//                                    self.anim.stop()
//
//
//                                    }
//                                }
//
//
//                            } else {
//                                if let obj = jsonObj!["msg"] as? [String:Any] {
//
//                                    if let msg = obj["message"] as? String {
//
//                                        self.anim.stop()
//
//                                    }
//                                }
//
//                            }
//                        }
//                    }
//
//                } catch let err as NSError {
//                    print("Error: \(err)")
//                    self.anim.stop()
//
////                    self.serverError(hud: hud)
//                }
//            } else {
//                print("Error")
//                self.anim.stop()
////                self.serverError(hud: hud)
//            }
//        }
//
//    }
    
    
    func getUserInfo() {
        
        
        // http://kenz-alarab.com.dedi5536.your-server.de/app2/user-info?
        
        let link = "http://faris-alroya.com.dedi5536.your-server.de/en/app/user-info?uid=65"
        
        let username = "hamza"
        let password = "123"
        
        
        

        let credential = URLCredential(user: username, password: password, persistence: .forSession)

        AF.request(link, method: .get ).authenticate(with: credential).responseJSON { response in
            switch response.result {
            case .success(let value):
                
                self.anim.stop()
                
                if let jsonArray = value as? [[String: Any]] {
                    
                    for profile in jsonArray {
                        let model = UserProfile(data: profile)
                        self.userts.append(model)
                    }
                }
                
                DispatchQueue.main.async {
                    self.usernameField.text = self.userts[0].username ?? ""
                    self.phonenumField.text = self.userts[0].phone_number ?? ""
                    self.emailField.text = self.userts[0].mail ?? ""
                    
                    if let url = URL(string: self.userts[0].user_picture ?? "") {
                        
                        self.profileImage.kf.setImage(with: url)

                    }
                }
                
            case .failure(let error):
                self.anim.stop()
                print("Error: \(error)")
                // Handle the error
                // self.serverError(hud: hud)
            }
        }
    }
    
    func updateProfile() {
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()

        let link = URL(string: "")

        let param: [String: Any] = [
            "uid": Helper.shared.getId() ?? "",

        ]

      

        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in param {
                if let data = "\(value)".data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
            if let imageData = self.img!.jpegData(compressionQuality: 0.5) {
                multipartFormData.append(imageData, withName: "dashbord", fileName: "image.jpg", mimeType: "car.jpg")
            }
        }, to: link!)
        .response { response in
            if response.error == nil {
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    if jsonObj != nil {
                        
                        
                        if let obj = jsonObj!["msg"] as? [String:Any] {
                            
                            let  status = obj["status"] as? Int
                            let  message = obj["message"] as? String
                            
                    if status == 200 {
                                
                        self.showSuccessHud(msg: message ?? "", hud: hud)
                              
                                
                            }
                            
                            
                            else {
                                
                                
                                self.showErrorHud(msg: message ?? "", hud: hud)
                                      
                            }
                            
                        }
                        
                        
                        
                        
                        
                    }
                } catch let err as NSError {
                    print("Error: \(err)")

                    self.serverError(hud: hud)
                }
            } else {
                print("Error")
                
                self.serverError(hud: hud)
            }
        }
    }
}
