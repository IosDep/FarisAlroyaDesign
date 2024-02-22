//
//  PersonalInfoVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit
import Alamofire

class PersonalInfoVC: UIViewController , UITextFieldDelegate{
    
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
    //    @IBOutlet weak var birthDate: UIDatePicker!
    
    //
    //
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var monthTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    
    
    //
    //    static var flag : Int?
    //    static var counterValue : Int = 1
    //    static var bandName : String?
    //    static var bandCountry : String?
    //    static var bandActivityType : String?
    //    static var NumberOfBands : String?
    //
    static var poetFirstName : String?
    static var poetLastName : String?
    static var poetUsername : String?
    static var poestPassword : String?
    static var poetNat : String?
    static var poetBirthDate : String?
    static var poetGender : String?
    
    var flag : Int?
    var didPickDate : Bool = false
    var didPickGender : Bool = false
    
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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        dayTextField.delegate = self
        monthTextField.delegate = self
        yearTextField.delegate = self
        
        // Set the keyboard type for each text field
        
//        monthTextField.keyboardType = .numberPad
//        yearTextField.keyboardType = .numberPad
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
        
        let datePicker = UIDatePicker()
         datePicker.datePickerMode = .date // You can set this to .time or .dateAndTime as needed
         datePicker.preferredDatePickerStyle = .wheels // Set the style to wheels

         // Configure the date picker to update dayTextField when the date changes
         datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

         // Set the date picker as the input view for the dayTextField
         dayTextField.inputView = datePicker

         // Optionally, you can add a toolbar with a 'Done' button to dismiss the picker
       
        self.createToolbar()
    }
    
    func createToolbar(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "تم", style: .plain, target: self, action: #selector(otherDismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.dayTextField.inputAccessoryView = toolBar
        self.monthTextField.inputAccessoryView = toolBar
        self.yearTextField.inputAccessoryView = toolBar
        self.usernameField.inputAccessoryView = toolBar
        self.passwordField.inputAccessoryView = toolBar
        self.firstNameField.inputAccessoryView = toolBar
        self.lastNameField.inputAccessoryView = toolBar
    }
    
    @objc func dateChanged(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dayTextField.text = formatter.string(from: datePicker.date)
    }

    // Selector method to dismiss the date picker
    @objc func otherDismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        didPickDate = true
        
        let currentText = textField.text ?? ""
        guard let range = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        
        // Limit the number of characters to 2 for day and month, and 4 for year
        switch textField {
        case dayTextField, monthTextField:
            return updatedText.count <= 2
        case yearTextField:
            return updatedText.count <= 4
        default:
            return true
        }
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let maxLength = textField == yearTextField ? 4 : 2
        
        if let text = textField.text, text.count >= maxLength {
            switch textField {
            case dayTextField:
                monthTextField.becomeFirstResponder()
            case monthTextField:
                yearTextField.becomeFirstResponder()
            default:
                break
            }
        }
    }
    
    
    func getBirthDate()  {
        guard let day = dayTextField.text, let month = monthTextField.text, let year = yearTextField.text else {
            return
        }

        guard !day.isEmpty, !month.isEmpty, !year.isEmpty else {
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "dd/MM/yyyy"

        guard let date = dateFormatter.date(from: "\(day)/\(month)/\(year)") else {
            return
        }
        
        PersonalInfoVC.poetBirthDate = dateFormatter.string(from: date)
        
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
    
    
    @IBAction func genderPressed(_ sender: UIButton) {
        
        didPickGender = true
        
        if sender.tag == 1 {
            PersonalInfoVC.poetGender = "1"
            self.flag = 1
        }
        
        
        else if sender.tag == 2 {
            
            PersonalInfoVC.poetGender = "2"
            self.flag = 2
        }
        
        self.highlightGender()
        
        
        
    }
    
    func highlightGender() {
        
        if flag == 1 {
            
            maleBtn.setImage(UIImage(named: "circlefill 1"), for: .normal)
            femaleBtn.setImage(UIImage(named: "check"), for: .normal)
            
        }
        
        else {
            
            femaleBtn.setImage(UIImage(named: "circlefill 1"), for: .normal)
            maleBtn.setImage(UIImage(named: "check"), for: .normal)

        }
        
        
    }
    
    

    @IBAction func nextPressed(_ sender: Any) {
//        && didPickDate == true && didPickGender == true 
        if firstNameField.text != "" && lastNameField.text != "" && usernameField.text != "" && passwordField.text != ""{
            
            PersonalInfoVC.poetBirthDate = self.dayTextField.text ?? ""
            PersonalInfoVC.poetFirstName = firstNameField.text ?? ""
            PersonalInfoVC.poetLastName = lastNameField.text ?? ""
            PersonalInfoVC.poetUsername = usernameField.text ?? ""
            PersonalInfoVC.poestPassword = passwordField.text ?? ""
            PersonalInfoVC.poetNat = "1"
            
            
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ActivitiesVC") as! ActivitiesVC
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        else {
            
            self.showWarningHud(msg: "Please fill required data".localized())
        }
                
                

//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
        
        
        
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
