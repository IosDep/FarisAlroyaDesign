//
//  Loginvc.swift
//  FarisAlroya
//  Created by Blue Ray on 11/11/2023.


import UIKit
import Alamofire
import JGProgressHUD

class Loginvc: UIViewController {
    
    @IBOutlet weak var usernameField: DesignableTextFeild!
    @IBOutlet weak var passwordField: DesignableTextFeild!
    
    
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func forgotPassword(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
        
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        
        
        Helper.shared.saveId(id: "1")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.isLogin()
        
        
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
        let vc = storyBoard.instantiateViewController(withIdentifier: "PersonalInfoVC") as! PersonalInfoVC
        
//        self.navigationController?.pushViewController(vc, animated: true)
        

        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    
        
    }
    
    
    func loginRequest(){
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)
        
        let link = URL(string: "http://kenz-alarab.com.dedi5536.your-server.de/app/login")
        
        let param :[String:Any] = [
            
            "user": usernameField.text ?? "" ,
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
                                
                                self.showSuccessHud(msg: message ?? "", hud: hud)

                                
                                if let data = jsonObj!["data"] as? [String: Any] {
                                                                   
                                        
                                    if let id = data["id"] as? String {
                                        
                                        Helper.shared.saveId(id: id ?? "")
                                        
                                    }
                                        
                                    if let role = data["role"] as? String {
                                        
                                        Helper.shared.saveRole(role: role ?? "")
                                    }
                                    
                                    if let email = data["email"] as? String {
                                        
                                        Helper.shared.saveEmail(email: email ?? "")
                                    }
                                       
                                       
                                    
                                    DispatchQueue.main.async {
                                        
                                hud.dismiss(afterDelay: 1.5, animated: true ,completion: {
                                        
                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                        appDelegate.isLogin()
                                        
                                        
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
