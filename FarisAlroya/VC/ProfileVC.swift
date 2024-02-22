//
//  ProfileVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit
import SDWebImage
import Lottie
import Lottie
import JGProgressHUD
import Alamofire
import MOLH
import CDAlertView
import AVFoundation
import Photos
class ProfileVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    let viewModel = MainViewModel()
    var anim: LottieAnimationView!

    
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var birthDate: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var userImage: UIImageView!

    @IBOutlet weak var userNameTxt: UITextField!

    @IBOutlet weak var phoneNumber: UITextField!

    //    image_picker
    var imagePicker = UIImagePickerController()
    var img: UIImage?
var userImageTxt =  ""
    override func viewDidLoad() {
        super.viewDidLoad()
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
        imagePicker.delegate = self

        
        getUserProfile()
       
    }
    

    
    @IBAction func dismiss(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    private func getUserProfile() {

    
        viewModel.getUserProfileData() { [weak self] success, error in
                if success {
                    // Update your UI with the results
                    // For example, reload a table view or collection view
                    let data  = self?.viewModel.profileList?.results
                    self?.userImageTxt = data?.profile_image ?? ""
                    
                    if  self?.userImageTxt == ""{
                        self?.userImage.image = UIImage(named: "navlogo")
                    }else {
                        self?.userImage.sd_setImage(with:(URL(string: self?.userImageTxt ?? "")), completed: { (image, error, cachType, url) in
                            if error == nil {
                                self?.userImage .image = image!
                                
                            }
                        })
                    }
                    print("FGHJ",data?.user_name ?? "")
                    self?.username.text =  data?.user_name ?? ""
                    self?.userNameTxt.text =  data?.user_name ?? ""
                    self?.birthDate.text =  data?.date_of_birth ?? ""
                    self?.gender.text = data?.sex ?? ""
                    self?.email.text =  data?.email ?? ""
                    self?.firstName.text =  data?.first_name ?? ""
                    self?.phoneNumber.text  = data?.phone ?? ""
                    self?.anim.stop()

                    self?.anim.isHidden = true

                } else if let error = error {
                    // Handle the error, maybe show an alert to the user
                    print("Error occurred during search: \(error.localizedDescription)")
                    self?.showErrorHud(msg:"Error occurred during search:" )
                    self?.anim.isHidden = true

                    
                }
            }
        }
  

    @IBAction func update(_ sender: Any) {
        
        self.updateUser()
    }
    
    @IBAction func deleteMyAccoun(_ sender: Any) {
        
        
        
        

            var tittel = "سيتم اغلاق الحساب "
            var message = "سيتطلب اغلاق الحساب من ٢٤-٤٨ ساعة عمل"

            var action_btn = "الغاء"
            var skip_action = "تأكيد"
            
            if MOLHLanguage.isArabic(){
         tittel = "Your Account Will Be Removed "
         message = "If You Agree Click On Confirm it may Take 24-48 Hours"

         action_btn = "Cancel"
         skip_action = "Confirm"
        
            }
            
        let alert = CDAlertView(title: tittel, message:  message, type: .error)
        
        
            let dismis_action = CDAlertViewAction(title: action_btn , font: UIFont.systemFont(ofSize: 17) , textColor: UIColor.red, backgroundColor: UIColor.white, handler: { action in
                
                
                return true
            })

            let Confirm = CDAlertViewAction(title: skip_action , font: UIFont.systemFont(ofSize: 17) , textColor: UIColor.red, backgroundColor: UIColor.white, handler: { action in
                let defaults = UserDefaults.standard

                defaults.setValue(nil, forKeyPath: "uid")
                defaults.synchronize()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.notLogin()
                return true
            })
            alert.add(action: Confirm)

            alert.add(action: dismis_action)

        alert.show()
            
    }
    @IBAction func logouts(_ sender: Any) {
        

            var tittel = "كنز العرب"
            var message = "هل انت متاكد من تسجيل الخروج"

            var action_btn = "الغاء"
            var skip_action = "تأكيد"
            
//            if MOLHLanguage.isArabic(){
//         tittel = "Your Account Will Be Removed "
//         message = "If You Agree Click On Confirm it may Take 24-48 Hours"
//
//         action_btn = "Cancel"
//         skip_action = "Confirm"
//
//            }
            
        let alert = CDAlertView(title: tittel, message:  message, type: .error)
        
        
            let dismis_action = CDAlertViewAction(title: action_btn , font: UIFont.systemFont(ofSize: 17) , textColor: UIColor.red, backgroundColor: UIColor.white, handler: { action in
                
                
                return true
            })

            let Confirm = CDAlertViewAction(title: skip_action , font: UIFont.systemFont(ofSize: 17) , textColor: UIColor.red, backgroundColor: UIColor.white, handler: { action in
                let defaults = UserDefaults.standard

                defaults.setValue("-", forKeyPath: "token")
                defaults.synchronize()
                
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.notLogin()

                return true
            })
            alert.add(action: Confirm)

            alert.add(action: dismis_action)

        alert.show()
    
        
    }
    
    @IBAction func agrrements(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AgreemntVc") as! AgreemntVc
        
        self.present(vc, animated: true)
        
    }
    
    
    @IBAction func uplaodeBtn(_ sender: Any) {
        var str = "إختر صورة"
        var str2 = "معرض الصور"
        var str4 = "الكاميرا"

        var str3 = "إلغاء"

        let alert = UIAlertController(title:str, message: nil, preferredStyle: .actionSheet)


        alert.addAction(UIAlertAction(title: str2, style: .default, handler: { _ in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction(title: str4, style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction.init(title: str3, style: .cancel, handler: nil))

     
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
    
    func openGallary() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            // Access has been granted.
            showImagePicker(sourceType: .photoLibrary)
        case .notDetermined:
            // Access has not been determined.
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    DispatchQueue.main.async {
                        self.showImagePicker(sourceType: .photoLibrary)
                    }
                }
            }
        case .denied, .restricted:
            // Access has been denied or restricted.
            DispatchQueue.main.async {
                self.showAccessDeniedAlert()
            }
        @unknown default:
            // Handle future enum cases
            DispatchQueue.main.async {
                self.showAccessDeniedAlert()
            }
        }
    }
    func showAccessDeniedAlert() {
        let alert = UIAlertController(title: "Access Denied", message: "Please enable access to your photos in Settings.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = ["public.image"]
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }

    func uploade_Image(img: UIImage) {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

        guard let updateProfileURL = URL(string: ServerConstants.BASE_URL + ServerConstants.UPDATEPROFILE) else {
            print("Invalid URL")
            return
        }

        var sex = 0
        if self.gender.text == "Male" {
            sex = 1
        } else {
            sex = 2
        }

        let updateProfileParam: [String: Any] = [
            "full_name": self.firstName.text ?? "",
            "user_name": self.username.text ?? "",
            "date_of_birth": self.birthDate.text ?? "",
            "sex": sex,
            "country_phone_id": 102,
            "phone": self.phoneNumber.text ?? "",

            "email": self.email.text ?? ""
        ]

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Helper.shared.getUserToken() ?? "")"
        ]

        AF.upload(multipartFormData: { multipartFormData in
            if let imgData = self.img?.jpegData(compressionQuality: 0.2) {
                multipartFormData.append(imgData, withName: "profile_image", fileName: "imageName.jpg", mimeType: "image/jpeg")
            }

            for (key, value) in updateProfileParam {
                if let stringValue = value as? String {
                    multipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
                } else if let intValue = value as? Int {
                    let stringValue = "\(intValue)"
                    multipartFormData.append(stringValue.data(using: .utf8)!, withName: key)
                }
            }
        }, to: updateProfileURL, method: .post, headers: headers).responseJSON { response in
            switch response.result {
            case .success:
                do {
                    if let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any] {
                        if let msg = jsonObj["msg"] as? [String: Any], let status = msg["status"] as? Int {
                            if status == 200, let message = msg["message"] as? String {
                                self.show(message: message, messageType: .success)
                                hud.dismiss()

                            } else if let message = msg["message"] as? String {
                                self.show(message: message, messageType: .failure)
                                hud.dismiss()
                            }
                        }
                    }
                } catch {
                    print("Error: \(error)")
                    self.serverError(hud: hud)
                }
            case .failure(let error):
                print("Error: \(error)")
                self.serverError(hud: hud)
            }
        }
    }

    
    
    func updateUser(){
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)

        guard let updateProfileURL = URL(string: ServerConstants.BASE_URL + ServerConstants.UPDATEPROFILE) else {
            print("Invalid URL")
            return
        }

        var sex = 0
        if self.gender.text == "Male" {
            sex = 1
        } else {
            sex = 2
        }

        let updateProfileParam: [String: Any] = [
            "full_name": self.firstName.text ?? "",
            "user_name": self.username.text ?? "",
            "date_of_birth": self.birthDate.text ?? "",
            "sex": sex,
            "country_phone_id": 102,
            "phone": self.phoneNumber.text ?? "",

            "email": self.email.text ?? "",
            "lang" :  "ar"
        ]

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Helper.shared.getUserToken() ?? "")"
        ]
        
        AF.request(updateProfileURL, method: .post, parameters: updateProfileParam,headers:headers).response { (response) in
            if response.error == nil {
                do {
                    
               
                    if let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any] {
                        if let msg = jsonObj["msg"] as? [String: Any], let status = msg["status"] as? Int {
                            if status == 200, let message = msg["message"] as? String {
                                self.show(message: message, messageType: .success)
                                self.navigationController?.popViewController(animated: true)
                                hud.dismiss()

                            } else if let message = msg["message"] as? String {
                                self.show(message: message, messageType: .failure)
                                hud.dismiss()
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
            let alert  = UIAlertController(title: "تنبيه", message: "الرجاء الذهاب الى الاعدادات للسماح بالوصول الى الكاميرا", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkCamera() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch authStatus {
        case .denied:
            let alert  = UIAlertController(title: "تنبيه", message: "الرجاء الذهاب الى الاعدادات للسماح بالوصول الى الكاميرا", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "نعم", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        default:
            print("some")
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.editedImage] as? UIImage {
//            self.img_prof.image = image
            
        
            self.img = image
            self.uploade_Image(img: self.img!)
            
            
            
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            self.img_prof.image = image
            self.img = image
        }

    }
    
}
