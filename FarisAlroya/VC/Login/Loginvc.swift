//
//  Loginvc.swift
//  FarisAlroya
//  Created by Blue Ray on 11/11/2023.


import UIKit
import Alamofire
import JGProgressHUD

class Loginvc: UIViewController {
    
    @IBOutlet weak var usernameField: PrimaryTextField!
    @IBOutlet weak var passwordField: PrimaryTextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    //        usernameField.text = "mohammadAhmad"
    //        passwordField.text = "123"

        createToolbar()

    }

    func createToolbar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "تم", style: .plain, target: self, action: #selector(otherDismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.usernameField.inputAccessoryView = toolBar
        self.passwordField.inputAccessoryView = toolBar
    }
    // Selector method to dismiss the date picker
    @objc func otherDismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func forgotPassword(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        
        self.present(vc, animated: true)
        
        
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        
        
        if usernameField.text != "" || usernameField.text != "" {
            
            loginRequest()
            
        }
        
        else {
            
            self.showWarningHud(msg: "جميع الحقول مطلوبة".localized())
        }
        
//        if usernameField.text != "" && passwordField.text != "" {
//
//            self.loginRequest()
//        }
//
//        else {
//
//            self.showWarningHud(msg: "ادخل جميع الحقول")
//        }
//
        
            }
    
    
    @IBAction func signUpPressed(_ sender: Any) {
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.creteAccont()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignUPViewController") as! SignUPViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        

//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
    
        
    }
    
    
    func loginRequest(){
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        let link = URL(string: ServerConstants.BASE_URL  + ServerConstants.UserLogin)
        
        let param :[String:Any] = [
            
            "user_name": usernameField.text ?? "" ,
            "password" : passwordField.text ?? ""
        ]
        
            
        AF.request(link!, method: .post, parameters: param).response { (response) in
            if response.error == nil {
                do {
                    
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    if jsonObj != nil {
                        
                        if let obj = jsonObj!["msg"] as? [String:Any] {
                            let  status = obj["status"] as? Int
                            let  message = obj["message"] as? String
                            
                            
                            
                            if status == 200 {
                                
                                self.showSuccessHud(msg: "تم تسجيل الد خول بنجاح", hud: hud)

                                
                                if let data = jsonObj!["results"] as? [String: Any] {
                                                                   
                                        
                                    if let id = data["id"] as? Int {
                                        print("IIIIIDDDDD",id)
                                        Helper.shared.saveNewId(id: id)
                                        
                                    }
                                        
                                    if let role = data["role"] as? String {
                                        
                                        Helper.shared.saveRole(role: role ?? "")
                                    }
                                    
                                    if let email = data["email"] as? String {
                                        
                                        Helper.shared.saveEmail(email: email ?? "")
                                    }
                                       
                                       
                                    if let user_name = data["user_name"] as? String {
                                        
                                        Helper.shared.saveUsername(user_name: user_name)
                                    }
                                    
                                    
                                    if let phone_number = data["phone_number"] as? String {
                                        
                                        Helper.shared.savePhone(phone_number: phone_number ?? "")
                                    }
                                    
                                    if let user_picture = data["user_picture"] as? String {
                                        
                                        Helper.shared.saveUser_picture(user_picture: user_picture)
                                    }
                                    
                                    if let token = data["token"] as? String {
                                        Helper.shared.saveUserToken(user_picture: token)
                                        Helper.shared.saveUserTokenfForGuest(user_picture: "0")

                                    }
                                    
                                    
                                    
                                    DispatchQueue.main.async {
                                        
                                hud.dismiss(afterDelay: 1.5, animated: true ,completion: {
                                        
                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        appDelegate.isLogin()
                                        
                                        
                                                                                })
                                        
                                        
                                    }
                                }
                                
                                
                            } else {
//                                self.showWarningHud(msg: msg ?? "", hud: hud)
                                self.show(message: "يوجد خطاء", messageType: .failure)
                                hud.dismiss()
                                if let obj = jsonObj!["msg"] as? [String:Any] {
                                    
                                    //
                                    if let msg = obj["message"] as? String {
                                    
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
    
    @IBAction func guestBtn(_ sender: Any) {
        
        self.loginRequestGUEST()
        
    }
    func loginRequestGUEST(){
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        let link = URL(string: ServerConstants.BASE_URL  + ServerConstants.UserLogin)
        
        let param :[String:Any] = [
            
            "user_name": "testUser18" ,
            "password" : "12345678"
        ]
        
        
        AF.request(link!, method: .post, parameters: param).response { (response) in
            if response.error == nil {
                do {
                    
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    if jsonObj != nil {
                        
                        if let obj = jsonObj!["msg"] as? [String:Any] {
                            let  status = obj["status"] as? Int
                            let  message = obj["message"] as? String
                            
                            
                            
                            if status == 200 {
                                
//                                self.showSuccessHud(msg: message ?? "", hud: hud)
                                
                                
                                if let data = jsonObj!["results"] as? [String: Any] {
                                    
                                    
//                                    if let id = data["id"] as? String {
//                                        
//                                        Helper.shared.saveId(id: id ?? "")
//                                        
//                                    }
//                                    
//                                    if let role = data["role"] as? String {
//                                        
//                                        Helper.shared.saveRole(role: role ?? "")
//                                    }
//                                    
//                                    if let email = data["email"] as? String {
//                                        
//                                        Helper.shared.saveEmail(email: email ?? "")
//                                    }
//                                    
//                                    
//                                    if let user_name = data["user_name"] as? String {
//                                        
//                                        Helper.shared.saveUsername(user_name: user_name)
//                                    }
//                                    
//                                    
//                                    if let phone_number = data["phone_number"] as? String {
//                                        
//                                        Helper.shared.savePhone(phone_number: phone_number ?? "")
//                                    }
//                                    
//                                    if let user_picture = data["user_picture"] as? String {
//                                        
//                                        Helper.shared.saveUser_picture(user_picture: user_picture)
//                                    }
                                    
                                    if let token = data["token"] as? String {
                                        Helper.shared.saveUserToken(user_picture: token)
                                        Helper.shared.saveUserTokenfForGuest(user_picture: "1")


                                    }
                                    
                                    
                                    
                                    DispatchQueue.main.async {
                                        
                                        hud.dismiss(afterDelay: 1.5, animated: true ,completion: {
                                            
                                            
                                            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                            let vc = storyBoard.instantiateViewController(withIdentifier: "VidViewController") as! VidViewController
                                            vc.isHome = 0
                                            vc.isGust = 1
                                            self.navigationController?.pushViewController(vc, animated: true)
                                            
                                            
                                            
                                        })
                                        
                                        
                                    }
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
}
