//
//  SignUPViewController.swift
//  KEENZALARAB
//
//  Created by Osama Abu hdba on 08/01/2024.
//

import UIKit
import ViewAnimator
import JGProgressHUD
import Alamofire
import MOLH
import CountryPickerView
class SignUPViewController: BaseViewController, CountryPickerViewDelegate {
  
    
    override var navigationHidingMode: BaseViewController.BarHidingMode{.alwaysVisible}
    
    enum TypeOfRegisterSteps{
        case personalInfoStep
        case registerStep
        case userInterests
    }
    
    private var typeOfRegisterSteps: TypeOfRegisterSteps = .personalInfoStep
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionView: DynamicHeightCollectionView!
    
    
    @IBOutlet weak var personalInfoStack: UIStackView!
    @IBOutlet weak var registerStack: UIStackView!
    @IBOutlet weak var InterestsStack: UIStackView!
    
    @IBOutlet weak var stepOneImage: UIImageView!
    //    @IBOutlet weak var stepTwoImage: UIImageView!
    //    @IBOutlet weak var stepThreeImage: UIImageView!
    
//    @IBOutlet weak var stepOneStack: UIStackView!
//    @IBOutlet weak var stepTwoStack: UIStackView!
//    @IBOutlet weak var stepThreeStack: UIStackView!
    
    @IBOutlet weak var mobileNumberContainerView: UIView!
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var firstNameTextField: PrimaryTextField!
    @IBOutlet weak var lastNameTextField: PrimaryTextField!
    @IBOutlet weak var usernameTextField: PrimaryTextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var birthdayTextField: PrimaryTextField!
    @IBOutlet weak var emailTextField: PrimaryTextField!
    
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var loginButton: UILabel!
    
    @IBOutlet weak var femaleButton: CheckButton!
    @IBOutlet weak var maleButton: CheckButton!
    @IBOutlet weak var privacyPolicyCheckButton: CheckButton!
    
    @IBOutlet weak var passwordContainerView: UIView!
    
    private let datePicker = UIDatePicker()
    private var gender = 1
    private var interestsW = 0
    private var countryId = 103
    private var acceptPrivacyPolicy = 0
    private var selectedCountry: CountryCode?
    private var countries: [CountryCode] = []
    private var phoneNumebrTxt = "0"
    private var emailTxt = "0"
    @IBOutlet weak var countryPickerView: CountryPickerView!
    var phoneCode : String?

    private var selectedInterestsWords: [Int] = []
    private var interestsWords: [Hashtags] = [] {
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "انشاء حساب".localized()
        getHashtags()
        getCountryCodes()
        print(self.generateRandomNumberWithPrefix(),"3456789")
        
        countryPickerView.delegate = self

        countryPickerView.font = UIFont.systemFont(ofSize: 14.0)
        countryPickerView.setCountryByName("Jordan")
        
        self.phoneCode = "00962"
    }
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
       let pCode = countryPickerView.selectedCountry.phoneCode
        
        self.phoneCode = countryPickerView.selectedCountry.phoneCode.replacingOccurrences(of: "+", with: "00")

    }

    
    //    private func getHashtags(){
    //        performTask(taskOperation: AuthAPIs.getHashtags.request([Hashtags].self)).then({
    //            [weak self] in
    //            self?.interestsWords = $0
    //            self?.collectionView.reloadData()
    //            self?.fadeInCells()
    //        })
    //    }
    
    func getHashtags() {
        
        let hud = JGProgressHUD(style: .light)
        
        hud.show(in: self.view)
        
        let link = ServerConstants.BASE_URL + "/frontend/getHashtags"
        
        
        
        AF.request(link, method: .post).response { (response) in
            if response.error == nil {
                do {
                    
                    let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                    
                    if jsonObj != nil {
                        
                        if let obj = jsonObj!["msg"] as? [String:Any] {
                            let  status = obj["status"] as? Int
                            let  message = obj["message"] as? String
                            
                            let data = jsonObj!["results"] as? [[String: Any]]
                            
                            print("SDKajd","\(data)")
                            print("SDKajd123","\(obj)")
                            
                            if status == 200 {
                                
                                hud.dismiss()
                                
                                
                                if let data = jsonObj!["results"] as? [[String: Any]] {
                                    
                                    
                                    for i in data{
                                        let model = ActivitiesModel(data: i)
                                        self.interestsWords.append(Hashtags(id:model.id,hashtag: model.name))
                                    }
                                    
                                    self.collectionView.reloadData()
                                    self.fadeInCells()
                                    
                                    
                                    
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
    
    private func getCountryCodes(){
        //        performTask(taskOperation: AuthAPIs.getCountryCodes.request([CountryCode].self)).then({
        //            [weak self] in
        //            self?.countries = $0
        //            self?.countryId = $0.first?.id ?? 0
        //            self?.countryCodeButton.setTitle($0.first?.countryCode, for: .normal)
        //        })
    }
    
    override func setupUI() {
        containerView.dropShadowWithCornerRaduis()
        fillData(.personalInfoStep)
        setupDatePicker()
        mobileNumberTextField.delegate = self
        mobileNumberTextField.textAlignment = .right
        passwordTextField.delegate = self
        passwordTextField.textAlignment = .right
        [mobileNumberContainerView, passwordContainerView].forEach({
            $0.layer.borderWidth = 1.0
            $0.layer.borderColor = #colorLiteral(red: 0.4238466024, green: 0.1600308716, blue: 0.6470095515, alpha: 0.5)
        })
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.register(CategoryCollectionViewCell.self)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = flowLayout
        
    }
    
    private func  setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.tintColor = #colorLiteral(red: 0.1609999985, green: 0.1879999936, blue: 0.3370000124, alpha: 1)
        datePicker.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 200, width: self.view.frame.width, height: 200)
        
        birthdayTextField.inputView = datePicker
        
        // Add a toolbar with a Done button to dismiss the date picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(datePickerDoneButtonTapped))
        toolbar.setItems([doneButton], animated: false)
        birthdayTextField.inputAccessoryView = toolbar
        
        let loc = Locale(identifier: "en")
        self.datePicker.locale = loc
    }
    
    @objc private func datePickerDoneButtonTapped() {
        // Dismiss the date picker when the Done button is tapped
        birthdayTextField.text = formatDate(datePicker.date)
        birthdayTextField.resignFirstResponder()
    }
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Use a POSIX locale
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC

        return dateFormatter.string(from: date)
    }
    
    
    private func fadeInCells() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.collectionView.reloadData()
            self.collectionView?.performBatchUpdates({
                let animations = [AnimationType.vector((CGVector(dx: 0, dy: 150)))]
                UIView.animate(views: self.collectionView.visibleCells(in: 0),
                               animations: animations,
                               duration: 3, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.allowUserInteraction])
            })
        }
    }
    
    
    func fillData(_ typeOfRegisterSteps: TypeOfRegisterSteps){
        switch typeOfRegisterSteps {
        case .personalInfoStep:
            InterestsStack.isHidden = true
            registerStack.isHidden = true
            personalInfoStack.isHidden = false
            
        case .registerStep:
            InterestsStack.isHidden = true
            registerStack.isHidden = false
            personalInfoStack.isHidden = true
            break
        case .userInterests:
//            InterestsStack.isHidden = false
//            registerStack.isHidden = true
//            personalInfoStack.isHidden = true
            break
        }
    }
    
    func changeUIToStepsButton(_ typeOfRegisterSteps: TypeOfRegisterSteps){
        switch typeOfRegisterSteps {
        case .personalInfoStep:
            break
        case .registerStep:
            stepOneImage.image = UIImage(named: "registerImage-selected")
            fillData(.registerStep)
            break
        case .userInterests:
            stepOneImage.image = UIImage(named: "interested-selected")
            fillData(.userInterests)
            setupCollectionView()
            break
        }
    }
    
    
    override func connectActions() {
        countryCodeButton.UIViewAction { [weak self] in
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CountriesViewController") as! CountriesViewController
            vc.delegate =  self
            self?.presentWithNavigation(vc, modalPresentationStyle: .popover)
        }
        
        loginButton.UIViewAction {
            [weak self] in
            guard let self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        
        femaleButton.UIViewAction { [weak self] in
            guard let self = self else { return }
            femaleButton.isChecked.toggle()
            
            if femaleButton.isChecked {
                gender = 2
                maleButton.isChecked = false
            } else {
                gender = 0
            }
        }
        
        maleButton.UIViewAction { [weak self] in
            guard let self = self else { return }
            maleButton.isChecked.toggle()
            
            if maleButton.isChecked {
                gender = 1
                femaleButton.isChecked = false
            } else {
                gender = 0
            }
        }
        
        privacyPolicyCheckButton.UIViewAction {
            [weak self] in
            guard let self else { return }
            privacyPolicyCheckButton.isChecked.toggle()
            
            
            if privacyPolicyCheckButton.isChecked {
                acceptPrivacyPolicy = 1
            } else {
                acceptPrivacyPolicy = 0
            }
            
        }
//        stepOneStack.UIViewAction {
//            [weak self] in
//            guard let self else { return }
//            self.fillData(.personalInfoStep)
//        }
//
//        stepTwoStack.UIViewAction {
//            [weak self] in
//            guard let self else { return }
//            self.fillData(.registerStep)
//        }
//
//
//        stepThreeStack.UIViewAction {
//            [weak self] in
//            guard let self else { return }
//            self.fillData(.userInterests)
//
//        }
    }
    
    @IBAction func backToRegisterStep(_ sender: Any) {
        stepOneImage.image = UIImage(named: "registerImage-selected")
        fillData(.registerStep)
    }


    @IBAction func backToPersonalInfoStep(_ sender: Any) {
        stepOneImage.image = UIImage(named: "personailInfo")
        fillData(.personalInfoStep)
    }

    @IBAction func nextButtonToStepTwo(_ sender: Any) {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let birthday = birthdayTextField.text ?? ""
        
        
        if firstName.isEmpty || lastName.isEmpty || username.isEmpty || password.isEmpty  {
            show(message: "لا يمكن ترك الحقول فارغة", messageType: .failure)
            return
        } else if password.count < 8 {
            show(message: "كلمة المرور يجب ان تتكون من 8 رموز", messageType: .failure)
            return
        }
//        else if gender == 0 {
//            show(message: "يرجى اختيار الجنس", messageType: .failure)
//            return
//        }
//
        changeUIToStepsButton(.registerStep)
        
    }
    
    @IBAction func showPasswordButton(_ sender: UIButton) {
        if self.passwordTextField.isSecureTextEntry {
            self.passwordTextField.isSecureTextEntry = false
            sender.setImage(UIImage(named: "show_password"), for: .normal)
        } else {
            self.passwordTextField.isSecureTextEntry = true
            sender.setImage(UIImage(named: "hide_password"), for: .normal)
        }
    }
    
    @IBAction func nextButtonToStepThree(_ sender: Any) {
//        let phone = mobileNumberTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        if mobileNumberTextField.text == "" || mobileNumberTextField.text?.count == 0{
            self.phoneNumebrTxt = self.generateRandomNumberWithPrefix()
            
        }else {
            self.phoneNumebrTxt = self.mobileNumberTextField.text ?? ""
        }
        
        
        if emailTextField.text == "" || emailTextField.text?.count == 0{
            self.emailTxt = "\(self.generateRandomNumberWithPrefix())@test.com"
            
        }else {
            self.emailTxt =  self.emailTextField.text ?? ""
        }
        
        if  email.isEmpty {
            show(message: "جميع الحقول مطلوبة".localized(), messageType: .failure)
            return
        }
        
        if email.isValidEmail() == false{
                        show(message: "ادخل بريد الكتروني صالح", messageType: .failure)

            return

        }
        
        
        if acceptPrivacyPolicy == 0 {
            show(message: "يرجى الموافقة على الشروط والاحكام".localized(), messageType: .failure)
            return
        }
        registerUser()

        
//        changeUIToStepsButton(.userInterests)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        
        
        registerUser()
        
    }
}
    
    extension SignUPViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell: CategoryCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.setupCell(interestsWords[indexPath.item])
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return interestsWords.count
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
                print("don't touch me plz 🤬")
                selectedInterestsWords.append(interestsWords[indexPath.item].id ?? 0)
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell {
                print("don't touch me plz 🤬")
                for item in selectedInterestsWords {
                    if let index = selectedInterestsWords.firstIndex(of: item) {
                        selectedInterestsWords.remove(at: index)
                    }
                }
            }
        }
        
        
        func registerUser(){
            
            let hud = JGProgressHUD(style: .light)
            hud.textLabel.text = "Please Wait".localized()
            hud.show(in: self.view)
            
            
            let link = URL(string: ServerConstants.BASE_URL  + ServerConstants.addUser)
            

            
            let regParam  :[String:Any] = ["first_name": firstNameTextField.text ?? "",
                                           "last_name": lastNameTextField.text ?? "",
                                           "user_name": usernameTextField.text ?? "",
                                           "date_of_birth":"1995-04-21",
                                           "password": passwordTextField.text ?? "",
                                           "phone": phoneNumebrTxt,
                                           "email": emailTxt,
                                           "sex": gender ,
                                           "hashtags_ids": selectedInterestsWords,
                                           "country_phone_id": countryId ]
            
            
            AF.request(link!, method: .post, parameters: regParam,encoding: JSONEncoding.default).response { (response) in
                if response.error == nil {
                    do {
                        
                        let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
                        
                        
                        print("JJJDASKLdj",jsonObj)
                        if jsonObj != nil {
                            let  success = jsonObj?["success"] as? Bool
                            if success == false {
                                self.showSuccessHud(msg: "خطاء في التسجيل", hud: hud)
                                
                            }else {
                                
                                if let obj = jsonObj!["msg"] as? [String:Any] {
                                    let  status = obj["status"] as? Int
                                    let  message = obj["message"] as? String
                                    
                                    
                                    
                                    if status == 200 {
                                        
                                        
                                        if let data = jsonObj!["results"] as? [String: Any] {
                                            
                                            
                                            
                                            
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
                                                self.show(message: "تم التسجيل بنجاح ", messageType: .success)

                                                hud.dismiss(afterDelay: 1.5, animated: true ,completion: {
                                                    
                                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                                    appDelegate.isLogin()
                                                    
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
//                                    end status
                                }
//                                enOBJ
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
            
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.isLogin()
        }
        
        

        func generateRandomNumberWithPrefix() -> String {
            let prefix = "077"
            let randomNumberLength = 7 // Total length 10 - prefix length 3
            let randomDigits = (1...randomNumberLength).map { _ in Int.random(in: 0...9) }.map(String.init).joined()
            print(randomDigits)
            return prefix + randomDigits
        }

        
       
}

extension SignUPViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == mobileNumberTextField {
            mobileNumberContainerView.layer.borderColor = #colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.337254902, alpha: 1)
            mobileNumberContainerView.layer.borderWidth = 1.0
        }else {
            passwordContainerView.layer.borderColor = #colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.337254902, alpha: 1)
            passwordContainerView.layer.borderWidth = 1.0
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == mobileNumberTextField {
            mobileNumberContainerView.layer.borderColor = #colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.337254902, alpha: 0.5)
            mobileNumberContainerView.layer.borderWidth = 0.5
        }else {
            passwordContainerView.layer.borderColor = #colorLiteral(red: 0.1607843137, green: 0.1882352941, blue: 0.337254902, alpha: 0.5)
            passwordContainerView.layer.borderWidth = 0.5
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return true
    }

}

extension SignUPViewController: SelectCountriesViewControllerDelegate {
    func didFinishChooseCountry(countryName: String, countryId: Int) {
        countryCodeButton.setTitle("+ \(countryName)", for: .normal)
        self.countryId = countryId
    }
    

    func didFinishChooseCountry(_ sender: CountriesViewController, countries: [CountryCode], countryId: Int) {

    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
