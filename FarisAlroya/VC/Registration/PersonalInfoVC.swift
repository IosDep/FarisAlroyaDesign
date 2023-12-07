//
//  PersonalInfoVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit
import Alamofire

class PersonalInfoVC: UIViewController  {
   
   // , PickerDelegate
    
    
//    @IBOutlet weak var poetStack: UIStackView!
//    @IBOutlet weak var bandStack: UIStackView!
//    @IBOutlet weak var bandBtn2: UIButton!
//    @IBOutlet weak var poestBtn2: UIButton!
//    @IBOutlet weak var poetBtn: UIButton!
//    @IBOutlet weak var bandBtn: UIButton!
//    @IBOutlet weak var counter: UILabel!
//
//    @IBOutlet weak var countryBtn: DesignableButton!
//    @IBOutlet weak var countryField: DesignableTextFeild!
//    @IBOutlet weak var nameField: DesignableTextFeild!
//    @IBOutlet weak var activityField: DesignableTextFeild!
//
//
//    @IBOutlet weak var firstNameField: DesignableTextFeild!
//    @IBOutlet weak var lastNameField: UITextField!
//    @IBOutlet weak var birthDate: UIDatePicker!
//
//    static var flag : Int?
//    static var counterValue : Int = 1
//    static var bandName : String?
//    static var bandCountry : String?
//    static var bandActivityType : String?
//    static var NumberOfBands : String?
//
//    static var poetFirstName : String?
//    static var poetLastName : String?
//    static var poetCountry : String?
//    static var poetNat : String?
//    static var poetGender : String?
//    static var poetBirthDate : String?
//
//
//    var countries = [PickerDataModel]()
//    var nationalities = [PickerDataModel]()
//    var gender = [PickerDataModel]()




    
//    func getGender(gender: String, flag: Int, id: String) {
//        self.genderBtn.setTitle(gender, for: .normal)
//        self.genderBtn.setImage(UIImage(named: ""), for: .normal)
//
//        PersonalInfoVC.poetGender = id ?? ""
//
//
//    }
//
//    func getNationality(nat: String, flag: Int, id: String) {
//
//        self.natBtn.setTitle(nat, for: .normal)
//        self.natBtn.setImage(UIImage(named: ""), for: .normal)
//
//        PersonalInfoVC.poetNat = id ?? ""
//
//    }
//
//    func getCountry(country: String, flag: Int, id: String) {
//
//        self.countryBtn.setTitle(country, for: .normal)
//        self.countryBtn.setImage(UIImage(named: ""), for: .normal)
//
//        PersonalInfoVC.poetCountry = id ?? ""
//
//    }
//
//
//
//    @IBOutlet weak var natBtn: UIButton!
//    @IBOutlet weak var mainView: UIView!
//    @IBOutlet weak var genderBtn: UIButton!
//
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        mainView.layer.cornerRadius = 30
        
//        self.getCountries()
//        self.getNationalities()
//        self.getGender()
//
//        bandStack.isHidden = true
//        poetStack.isHidden = false
//
//        // 0 poet
//
//        PersonalInfoVC.flag = 0
        

        
        
        // flag = 0 -> poet stack shown
        
        // flag = 1 -> band stack shown
    }
    
    
    
    
//    @IBAction func userTypePressed(_ sender: UIButton) {
//
//        switch sender.tag {
//
//        case 0:
//
//                poetStack.isHidden = false
//                bandStack.isHidden = true
//                poestBtn2.setImage(UIImage(named: "circlefill"), for: .normal)
//                bandBtn2.setImage(UIImage(named: "circleempty"), for: .normal)
//
//
//            PersonalInfoVC.flag = 0
//
////            self.flag = 0
//
//        case 1:
//
//                poetStack.isHidden = true
//                bandStack.isHidden = false
//                poetBtn.setImage(UIImage(named: "circleempty"), for: .normal)
//                bandBtn.setImage(UIImage(named: "circlefill"), for: .normal)
//
//
//            PersonalInfoVC.flag = 1
//
//
////            self.flag = 1
//
//        default:
//            print("defaultt")
//        }
//
//    }
    

    @IBAction func signinPressed(_ sender: Any) {
        
        
        self.dismiss(animated: true)
        
//        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "Loginvc") as! Loginvc
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
        
    }
    

    @IBAction func nextPressed(_ sender: Any) {
        
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        
//        self.navigationController?.pushViewController(vc, animated: true)
        
                
                

        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
        
        
//        if PersonalInfoVC.flag == 0 {
//
//
//
//            PersonalInfoVC.poetFirstName = firstNameField.text ?? ""
//            PersonalInfoVC.poetLastName = lastNameField.text ?? ""
//
//
//        }
//
//        else if PersonalInfoVC.flag == 1 {
//
//            PersonalInfoVC.bandName = nameField.text ?? ""
//
////            PersonalInfoVC.bandCountry =
            
        }
        
        

//    }
    
    
    
    
    
    
    
    
//    @IBAction func pressNationality(_ sender: Any) {
//
//        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "PickerVC") as! PickerVC
//
//        vc.flag = 3
//        vc.data = nationalities
//        vc.pickerDelegate = self
//
//        self.present(vc, animated: true)
//
//
//
//    }
//
    
//    @IBAction func addPressed(_ sender: Any) {
//        PersonalInfoVC.counterValue += 1 ?? 1
//        updateCounterLabel()
//     }
//
   
//    @IBAction func removePressed(_ sender: Any) {
//
//        if PersonalInfoVC.counterValue > 0 {
//            PersonalInfoVC.counterValue -= 1
//                    updateCounterLabel()
//                }
//
//    }
//
//    func updateCounterLabel() {
//        counter.text = "\(PersonalInfoVC.counterValue)"
//        PersonalInfoVC.NumberOfBands = "\(PersonalInfoVC.counterValue ?? 0)" ?? ""
//
//       }
//
//
//
//    @IBAction func dateChanged(_ sender: UIDatePicker) {
//
//        let selectedDate = sender.date
//
//
//        let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd/MM/yyyy" // Specify the date format you need
//
//        let formattedDate = dateFormatter.string(from: selectedDate )
//
//        PersonalInfoVC.poetBirthDate = formattedDate
//
//
//    }
//
//
//
//    @IBAction func countryPressed(_ sender: Any) {
//
//        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "PickerVC") as! PickerVC
//
//        vc.flag = 1
//        vc.data = countries
//        vc.pickerDelegate = self
//
//        self.present(vc, animated: true)
//
//
//    }
//
//    @IBAction func genderPressed(_ sender: Any) {
//
//        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "PickerVC") as! PickerVC
//
//        vc.flag = 2
//        vc.data = self.gender
//        vc.pickerDelegate = self
//
//        self.present(vc, animated: true)
//
//
//    }
//
//
//
//    func getCountries() {
//        let link = "http://kenz-alarab.com.dedi5536.your-server.de/app/country-list"
//
//        AF.request(link, method: .get).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                if let jsonArray = value as? [[String: Any]] {
//                    for countryData in jsonArray {
//                        let model = PickerDataModel(data: countryData)
//                        self.countries.append(model)
//                    }
//                }
//            case .failure(let error):
//                print("Error: \(error)")
//                // Handle the error
//                // self.serverError(hud: hud)
//            }
//        }
//    }
//
//
//
//    func getNationalities() {
//        let link = "http://kenz-alarab.com.dedi5536.your-server.de/app/nationality-list"
//
//        AF.request(link, method: .get).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                if let jsonArray = value as? [[String: Any]] {
//                    for country in jsonArray {
//                        let model = PickerDataModel(data: country)
//                        self.nationalities.append(model)
//                    }
//                }
//            case .failure(let error):
//                print("Error: \(error)")
//                // Handle the error
//                // self.serverError(hud: hud)
//            }
//        }
//    }
//
//
//
//    func getGender() {
//        let link = "http://kenz-alarab.com.dedi5536.your-server.de/app/gender-list"
//
//        AF.request(link, method: .get).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                if let jsonArray = value as? [[String: Any]] {
//                    for genderData in jsonArray {
//                        let model = PickerDataModel(data: genderData)
//                        self.gender.append(model)
//                    }
//                }
//            case .failure(let error):
//                print("Error: \(error)")
//                // Handle the error
//                // self.serverError(hud: hud)
//            }
//        }
//    }
    
    
    
}
