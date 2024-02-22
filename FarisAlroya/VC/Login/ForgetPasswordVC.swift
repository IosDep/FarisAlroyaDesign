//
//  ForgetPasswordVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.


import UIKit

class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var txt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func sendCodePressed(_ sender: Any) {
        if self.txt.text == "" {
            self.showErrorHud(msg: "يحب كتابة رقم الهاتف او البريد الالكتروني")
            
        }else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.notLogin()
            }
            
            
//        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "OTPLoginVC") as! OTPLoginVC
//
//
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
    }
    
  
}
