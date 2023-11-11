//
//  Loginvc.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit

class Loginvc: UIViewController {
    

    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 30

    }
    

    @IBAction func forgotPassword(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ForgetPasswordVC") as! ForgetPasswordVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
        
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.isLogin()
    }
    
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.creteAccont()
        
        
//        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "PersonalInfoVC") as! PersonalInfoVC
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
    
        
    }
    
    
    
}
