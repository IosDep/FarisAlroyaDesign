//
//  LivePopUpVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 05/12/2023.
//

import UIKit

class LivePopUpVC: UIViewController {
    
    

    @IBOutlet var mainView: UIView!
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
