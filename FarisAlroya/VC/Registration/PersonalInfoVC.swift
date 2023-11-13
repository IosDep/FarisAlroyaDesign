//
//  PersonalInfoVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit

class PersonalInfoVC: UIViewController , PickerDelegate {
    
    
    
    @IBOutlet weak var poetStack: UIStackView!
    @IBOutlet weak var bandStack: UIStackView!
    @IBOutlet weak var bandBtn2: UIButton!
    @IBOutlet weak var poestBtn2: UIButton!
    @IBOutlet weak var poetBtn: UIButton!
    
    @IBOutlet weak var bandBtn: UIButton!
    
    var flag : Int?
    
    
    
    func getGender(gender: String, flag: String, id: String) {
        
        self.genderBtn.setTitle(gender, for: .normal)
        self.genderBtn.setImage(UIImage(named: ""), for: .normal)
        
        
    }
    
    @IBOutlet weak var natBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var genderBtn: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mainView.layer.cornerRadius = 30
        
        bandStack.isHidden = true
        poetStack.isHidden = false
        self.flag = 0

        
        // flag = 0 -> poet stack shown
        
        // flag = 1 -> band stack shown
    }
    
    
    
    @IBAction func userTypePressed(_ sender: UIButton) {
       
        switch sender.tag {
            
        case 0:
                
                poetStack.isHidden = false
                bandStack.isHidden = true
                poestBtn2.setImage(UIImage(named: "circlefill"), for: .normal)
                bandBtn2.setImage(UIImage(named: "circleempty"), for: .normal)
            
            
//            self.flag = 0
            
        case 1:
            
                poetStack.isHidden = true
                bandStack.isHidden = false
                poetBtn.setImage(UIImage(named: "circleempty"), for: .normal)
                bandBtn.setImage(UIImage(named: "circlefill"), for: .normal)
                
            
            
//            self.flag = 1
            
        default:
            print("defaultt")
        }
        
    }
    

    @IBAction func signinPressed(_ sender: Any) {
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Loginvc") as! Loginvc
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    

    @IBAction func nextPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ActivitiesVC") as! ActivitiesVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    @IBAction func pressNationality(_ sender: Any) {
       
        
        
    }
    
    
    
    @IBAction func genderPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "PickerVC") as! PickerVC
        
        vc.flag = 2
        vc.data = [PickerData(gender: "Female") , PickerData(gender: "Male")]
        vc.pickerDelegate = self
        
        self.present(vc, animated: true)
        
        
    }
    
    
    
    
}
