//
//  RegistrationVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit
import Alamofire
import JGProgressHUD
import CountryPickerView


class RegistrationVC: UIViewController  , CountryPickerViewDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var countryPickerView: CountryPickerView!
    
    var phoneCode : String?
    
    var checkFlag : Bool?

    
//    @IBOutlet weak var password: DesignableTextFeild!
//    @IBOutlet weak var username: DesignableTextFeild!
//
//    static var password : String?
//    static var username : String?
//    static var email : String?
//    @IBOutlet weak var mainView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryPickerView.delegate = self

        countryPickerView.font = UIFont.systemFont(ofSize: 14.0)
        countryPickerView.setCountryByName("Jordan")
        self.phoneCode = "00962"
       
//        countryPickerView.delegate = self
//        countryPickerView.dataSource = self
        self.createToolbar()
    }
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
       let pCode = countryPickerView.selectedCountry.phoneCode
        
        self.phoneCode = countryPickerView.selectedCountry.phoneCode.replacingOccurrences(of: "+", with: "00")

    }

    func createToolbar(){
//        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
//
//        let doneButton = UIBarButtonItem(title: "تم", style: .plain, target: self, action: #selector(dismissKeyboard))
//        toolBar.setItems([doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//
//        self.phoneField.inputAccessoryView = toolBar
//        self.email .inputAccessoryView = toolBar


        
    }
    // Selector method to dismiss the date picker
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func removeLeadingZero(from string: String) -> String {
        if string.hasPrefix("0") {
            return String(string.dropFirst())
        }
        return string
    }
    

    
    @IBAction func agreePressed(_ sender: Any) {
        
        if checkFlag == true {
            
            agreeBtn.setImage(UIImage(named: "check"), for: .normal)
            checkFlag = false
        }
        
        else {
            
            agreeBtn.setImage(UIImage(named: "circlefill 1"), for: .normal)
            checkFlag = true
        }
    }
    
    

    @IBAction func next(_ sender: Any) {
        
        
        if self.phoneField.text != "" {
            
            if let phoneCode = phoneCode, let phoneText = phoneField.text {
                
                let combinedPhoneNumber = phoneCode + self.removeLeadingZero(from: phoneText)
                                
            }
            else {
                self.showWarningHud(msg: "Please fill invalid mobile number".localized())
            }
        }
        
      
        
//        self.phoneField.text != ""
        if checkFlag == true && email.text != "" {
            
            self.registerPoet()
        }
        
        else {
            showWarningHud(msg: "Please fill required data".localized())
        }

        
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
    func registerPoet(){

        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Please Wait".localized()
        hud.show(in: self.view)


        let link = URL(string: ServerConstants.BASE_URL  + ServerConstants.addUser)


//        let commaSeparatedString = ActivitiesVC.activities.joined(separator: ",")

        let param :[String:Any] = [

            "first_name":  PersonalInfoVC.poetFirstName ?? "" ,
            "last_name" :  PersonalInfoVC.poetLastName ?? "" ,
            "sex" :  Int(PersonalInfoVC.poetGender ?? "") ,
            "nationality" :  PersonalInfoVC.poetNat ?? "" ,
//            "country_of_residence" :  PersonalInfoVC.poetNat ?? "" ,
            "hashtags_ids" :  ActivitiesVC.activities ,
            "user_name" : PersonalInfoVC.poetUsername ?? "" ,
            "password" : PersonalInfoVC.poestPassword ?? "",
            "email" : email.text ?? "" ,
            "phone" : phoneField.text ?? "077677897",
            "country_phone_id" :  103,
            "date_of_birth" : "1995-04-21"

        ]


        AF.request(link!, method: .post, parameters: param,encoding: JSONEncoding.default).response { (response) in
            if response.error == nil {
                do {

                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]

                    if jsonObj != nil {
                        let  success = jsonObj?["success"] as? Bool
                        if success == false {
                            self.showSuccessHud(msg: "خطاء في التسجيل", hud: hud)

                        }else {
                            
                            if let obj = jsonObj!["msg"] as? [String:Any] {
                                let  status = obj["status"] as? Int
                                let  message = obj["message"] as? String
                                
                                
                                
                                if status == 200 {
                                    
                                    if let poet_data = jsonObj!["results"] as? [String: Any] {
                                        
                                        let username = poet_data["user_name"] as? String
                                        
                                        UserDefaults.standard.set( username , forKey: "username")
                                        self.showSuccessHud(msg: message ?? "", hud: hud)

                                        
                                        DispatchQueue.main.async {
                                            
                                            hud.dismiss(afterDelay: 1.5, animated: true ,completion: {
                                                
                                                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                                appDelegate.notLogin()
                                                
                                            })
                                            
                                        }
                                    }
                                    
                                    
                                } else {
                                    
                                    hud.dismiss()
                                    
                                    if let obj = jsonObj!["msg"] as? [String:Any] {
                                        //
                                        if let msg = obj["message"] as? String {
                                            self.showWarningHud(msg: msg ?? "", hud: hud)
                                            hud.dismiss()
                                        }
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

  
    @IBAction func agrrement(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AgreemntVc") as! AgreemntVc
        
        self.present(vc, animated: true)
    }
    
}
