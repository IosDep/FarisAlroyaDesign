//
//  ForgetPasswordVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.


import UIKit

class ForgetPasswordVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func sendCodePressed(_ sender: Any) {
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "OTPLoginVC") as! OTPLoginVC
        
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
  
}
