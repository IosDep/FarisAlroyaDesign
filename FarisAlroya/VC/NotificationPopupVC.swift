//
//  NotificationPopupVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 06/12/2023.
//

import UIKit

class NotificationPopupVC: UIViewController {
    
    
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if touch?.view == self.mainView{
            
        }else {
            self.dismiss(animated: false,completion: {
            })
        }
    }
}
