//
//  OTPVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 11/11/2023.
//

import UIKit
import DPOTPView

class OTPVC: UIViewController {
    
    var flag : Int?
    
    
    @IBOutlet weak var otpView: DPOTPView!
    
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureOTP()
//        mainView.layer.cornerRadius = 30

    }

    @IBAction func sendCodePressed(_ sender: Any) {
        
        
        if flag == 1 {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "CreatePassVC") as! CreatePassVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }
        
        else {
            
            let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ActivitiesVC") as! ActivitiesVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            
        }
        
        
        
    }
    
    
    func configureOTP()  {
        
        otpView.count = 4
        otpView.spacing = 10
        otpView.fontTextField = UIFont(name: "HelveticaNeue-Bold", size: CGFloat(25.0))!
        otpView.dismissOnLastEntry = true
        otpView.isBottomLineTextField = true
        otpView.borderColor = .blue
        otpView.borderWidthTextField = 1
//        otpView.borderColorTextField = .black
//        txtOTPView.selectedBorderColorTextField = .blue
//        txtOTPView.isCursorHidden = true
    }

}
