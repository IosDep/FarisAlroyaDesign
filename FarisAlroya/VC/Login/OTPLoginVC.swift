//
//  OTPLoginVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 05/12/2023.
//

import UIKit

class OTPLoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func sendCodePressed(_ sender: Any) {
        
            
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CreatePassVC") as! CreatePassVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
       
        
    }
    


}
