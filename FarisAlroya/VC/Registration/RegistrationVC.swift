//
//  RegistrationVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit

class RegistrationVC: UIViewController {

    
    
    
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 30

    }
    

    
    @IBAction func signinPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Loginvc") as! Loginvc
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    

    @IBAction func register(_ sender: Any) {
        
        // not login in app delegate
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.notLogin()
        
        
    }
  

}
