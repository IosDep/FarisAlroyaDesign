//
//  PersonalInfoVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit

class PersonalInfoVC: UIViewController {
    
    

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
    

    @IBAction func nextPressed(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ActivitiesVC") as! ActivitiesVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
