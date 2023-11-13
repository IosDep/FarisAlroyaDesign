//
//  PickerVC.swift
//  FarisAlroya
//
//  Created by Blue Ray on 12/11/2023.
//

import UIKit

class PickerVC: UIViewController , UITableViewDataSource , UITableViewDelegate  {
    
  

    @IBOutlet weak var tableView: UITableView!
    
    var data = [PickerData]()
    var flag : Int?
    var pickerDelegate : PickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "PickerCell", bundle: nil), forCellReuseIdentifier: "PickerCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        

    }
    // flag =1 -> ationality
    // flag =2 -> gender
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath) as? PickerCell
        
        // nationality
        
        if flag == 1 {
            
        }
        
        
        // gender
        
        if flag == 2 {
            cell?.pickerLabel.text = data[indexPath.row].gender ?? ""

        }
        
        
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // nationality picker
        
        if flag == 1 {
            
        }
        
        // gender picker
        
        else if flag == 2 {
            
            self.pickerDelegate?.getGender(gender: data[indexPath.row].gender, flag: "", id: "")
            
        }
        
        
        self.dismiss(animated: true)
        
        
    }
    
    
}


protocol PickerDelegate {
    
    func getGender(gender : String , flag : String , id : String)
}


struct PickerData {
    
    var gender : String
    
}
