//
//  UpdateVeiwControllelr.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 21/02/2024.
//

import UIKit

class UpdateVeiwControllelr: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func updateBtn(_ sender: Any) {
        self.promptForUpdate()
        
    }
    
    
    
    func openAppStoreForUpdate() {
        let appID = "6476140586" // Replace YOUR_APP_ID with your actual app ID.
        if let url = URL(string: "https://apps.apple.com/app/id\(appID)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    
    func promptForUpdate() {
        let alertController = UIAlertController(
            title: "يوجد تحديث متاح",
            message: "يوجد نسخة محدثة من التطبيق اضغط متابعة لتحديث نسختك الحالية",
            preferredStyle: .alert
        )
        
        let updateAction = UIAlertAction(title: "تحديث", style: .default) { (action) in
            self.openAppStoreForUpdate()
        }
        let cancelAction = UIAlertAction(title: "لاحقا", style: .cancel, handler: nil)
        
        alertController.addAction(updateAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

}
