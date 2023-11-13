//
//  AccountSettingsVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit

class AccountSettingsVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 30

    }


    
    
    @IBAction func changePasswordPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CreatePassVC") as! CreatePassVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    

}
