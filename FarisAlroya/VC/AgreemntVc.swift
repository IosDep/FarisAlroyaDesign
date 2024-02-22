//
//  AgreemntVc.swift
//  FarisAlroya
//
//  Created by MOHAMMED JABER on 24/01/2024.
//

import UIKit

class AgreemntVc: UIViewController {

    @IBOutlet weak var txt: UITextView!
    var vl =  1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func dismiss(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func langs(_ sender: Any) {
        if vl == 1{
            self.vl = 2
            self.txt.text = ""

        }else {
            self.vl = 1
            self.txt.text = ""

        }
    }
}
