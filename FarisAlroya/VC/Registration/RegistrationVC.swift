//
//  RegistrationVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit
import Alamofire
import JGProgressHUD

class RegistrationVC: UIViewController {

    @IBOutlet weak var email: DesignableTextFeild!
    @IBOutlet weak var phoneField: DesignableTextFeild!
    
//    @IBOutlet weak var password: DesignableTextFeild!
//    @IBOutlet weak var username: DesignableTextFeild!
//
//    static var password : String?
//    static var username : String?
//    static var email : String?
//    @IBOutlet weak var mainView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        mainView.layer.cornerRadius = 30

    }
    

    
   
    

    @IBAction func next(_ sender: Any) {
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
        
//        self.navigationController?.pushViewController(vc, animated: true)
                
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
//        if PersonalInfoVC.flag == 0 {
//            self.registerPoet()
//
//        }
//
//        else if PersonalInfoVC.flag == 1 {
//
//            self.registerBand()
//        }
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.notLogin()
        
        
    }
    
    
//    func registerBand(){
//
//        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
//        hud.show(in: self.view)
//
//        let link = URL(string: "http://kenz-alarab.com.dedi5536.your-server.de/ar/app/band-registration")
//
//        let commaSeparatedString = ActivitiesVC.activities.joined(separator: ",")
//
//        let param :[String:Any] = [
//
//            "band_name":  PersonalInfoVC.bandName ?? "" ,
//            "country_of_residence" :  PersonalInfoVC.poetCountry ,
//            "type_of_activity" :  commaSeparatedString ?? "" ,
//            "number_of_band_members" : PersonalInfoVC.NumberOfBands ?? "" ,
//            "types_of_activities" :  commaSeparatedString ?? "" ,
//            "user_name" :  username.text ?? "" ,
//            "password" : password.text ?? "" ,
//            "email" : email.text ?? "" ,
//            "phone" : phoneField.text ?? ""
//
//
//
//        ]
//
//
//        AF.request(link!, method: .post, parameters: param).response { (response) in
//            if response.error == nil {
//                do {
//
//                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
//
//                    if jsonObj != nil {
//
//                        if let obj = jsonObj!["msg"] as? [String:Any] {
//                            let  status = obj["status"] as? Int
//                            let  message = obj["message"] as? String
//
//
//                                self.showSuccessHud(msg: message ?? "", hud: hud)
//
//                            if status == 200 {
//
//                                if let band_data = jsonObj!["band_data"] as? [String: Any] {
//
//
//                                    let username = band_data["username"] as? String
//
//                                        UserDefaults.standard.set( username , forKey: "email")
//
//
//
//                                    DispatchQueue.main.async {
//
//                                hud.dismiss(afterDelay: 1.5, animated: true ,completion: {
//
//                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                                        appDelegate.notLogin()
//
//                                                                                })
//
//
//                                    }
//                                }
//
//
//                            } else {
//
//
//                             let obj = jsonObj!["msg"] as? [String:Any]
//                                //
//                                if  let msg = obj!["message"] as? String {
//                                    print(message ?? "")
//
//                                    self.showWarningHud(msg: msg ?? "", hud: hud)
//
//                                }
//                            }
//                        }
//
//                    }
//                }
//
//
//                 catch let err as NSError {
//                    print("Error: \(err)")
//                     hud.dismiss()
////                    self.serverError(hud: hud)
//                }
//            } else {
//                print("Error")
//                hud.dismiss()
////                self.serverError(hud: hud)
//
//
//            }
//        }
//
//    }
//
//
//    func registerPoet(){
//
//        let hud = JGProgressHUD(style: .light)
//        hud.textLabel.text = "Please Wait".localized()
//        hud.show(in: self.view)
//
//
//        let link = URL(string: "http://kenz-alarab.com.dedi5536.your-server.de/ar/app/poet-registration")
//
//
//        let commaSeparatedString = ActivitiesVC.activities.joined(separator: ",")
//
//        let param :[String:Any] = [
//
//            "first_name":  PersonalInfoVC.poetFirstName ?? "" ,
//            "last_name" :  PersonalInfoVC.poetLastName ?? "" ,
//            "gender" :  PersonalInfoVC.poetGender ?? "" ,
//            "nationality" :  PersonalInfoVC.poetNat ?? "" ,
//            "country_of_residence" :  PersonalInfoVC.poetNat ?? "" ,
//            "types_of_activities" :  commaSeparatedString ?? "" ,
//            "user_name" : username.text ?? "" ,
//            "password" : password.text ?? "",
//            "email" : email.text ?? "" ,
//            "phone" : phoneField.text ?? "",
//            "barth_of_date" : PersonalInfoVC.poetBirthDate ?? ""
//
//        ]
//
//
//        AF.request(link!, method: .post, parameters: param).response { (response) in
//            if response.error == nil {
//                do {
//
//                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
//
//                    if jsonObj != nil {
//
//                        if let obj = jsonObj!["msg"] as? [String:Any] {
//                            let  status = obj["status"] as? Int
//                            let  message = obj["message"] as? String
//
//
//                            self.showSuccessHud(msg: message ?? "", hud: hud)
//
//                            if status == 200 {
//
//                                if let poet_data = jsonObj!["poet_data"] as? [String: Any] {
//
//                                    let username = poet_data["username"] as? String
//
//                                    UserDefaults.standard.set( username , forKey: "username")
//
//
//                                    DispatchQueue.main.async {
//
//                                    hud.dismiss(afterDelay: 1.5, animated: true ,completion: {
//
//                                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                                        appDelegate.notLogin()
//
//                                                                                })
//
//                                    }
//                                }
//
//
//                            } else {
//
//                                hud.dismiss()
//
//                                if let obj = jsonObj!["msg"] as? [String:Any] {
//                                    //
//                                    if let msg = obj["message"] as? String {
//                                    self.showWarningHud(msg: msg ?? "", hud: hud)
//                                    }
//                                }
//
//                            }
//                        }
//                    }
//                }
//
//                 catch let err as NSError {
//                    print("Error: \(err)")
//                     hud.dismiss()
//
////                    self.serverError(hud: hud)
//                }
//            } else {
//                print("Error")
//                hud.dismiss()
//
////                self.serverError(hud: hud)
//
//
//            }
//        }
//
//    }
//
  

}
